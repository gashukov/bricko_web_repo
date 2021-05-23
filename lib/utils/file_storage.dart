import 'dart:io';
import 'package:bricko_web/models/product_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bricko_web/main.dart';
import 'package:flutter/material.dart';
import 'package:bricko_web/pages/home.dart';
import 'package:archive/archive.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

class FilesStorage {
  // Directory _storageDir;
  String _productPath;
  String _pass = "a3kFefak33seqixncHEFJwjeeajefiu3flk";
  bool initialized = false;
  String instructionFileName = "instruction.zip";

  bool isInstructionDownloaded(ProductData productData) {
    if (initialized) {
      if (FileSystemEntity.typeSync(
              _productPath + "/${productData.pID}/$instructionFileName") !=
          FileSystemEntityType.notFound) {
        return true;
      }
    }
    return false;
  }

  Future<String> downloadInstructionArchive(ProductData productData) async {
    var file = File(_productPath + "/${productData.pID}/$instructionFileName");
    file.create(recursive: true);
    print("создали файл");
    var ref = FirebaseStorage.instance
        .ref()
        .child("/products/${productData.pID}/$instructionFileName");
    print("получили реф на скачивание ${productData.pID}");
    var download = ref.writeToFile(file);
    print("загружаем");
    dataStorage.setArchiveDownloadingNow(productData.pID, true);
    var bytesFuture =
        download.snapshot.totalBytes - download.snapshot.bytesTransferred;
    download.whenComplete(() {
      dataStorage.setArchiveDownloadingNow(productData.pID, false);
      print("загрузили ${file.lengthSync()}");
      if (bytesFuture > 0) {
        return file.path;
      } else {
        return null;
      }
    });
  }

  Future<String> getArchiveSize(String pID) async {
    print("SUS");
    if (dataStorage.preferences.containsKey("archive_size_$pID")) {
      return dataStorage.preferences.getString("archive_size_$pID");
    }
    return FirebaseStorage.instance
        .ref()
        .child("/products/${pID}/$instructionFileName")
        .getMetadata()
        .then((meta) {
      String size = (meta.size / 1000000).toStringAsFixed(1); // was sizeBytes
      dataStorage.preferences.setString("archive_size_$pID", size);
      return size;
    }).catchError((error) {
      print("Архива $pID не существует в базе данных: $error");
      return "-";
    });
  }

  List<ImageProvider> getInstructionImages(String pID) {
    List<ImageProvider> result = new List();

    List<int> bytes =
        File(_productPath + "/${pID}/$instructionFileName").readAsBytesSync();

    print("Bytes count ${bytes.length}");

    // Decode the Zip file
//    print("pass: $_pass");

    DateTime start = DateTime.now();
    List<ArchiveFile> archiveList =
        ZipDecoder().decodeBytes(bytes, verify: true, password: _pass).toList();
    DateTime artime = DateTime.now();
    archiveList.sort(
        (a, b) => _getPageNumber(a.name) > _getPageNumber(b.name) ? 1 : -1);
    DateTime afterSort = DateTime.now();

    print("end - start ${afterSort.difference(start).inMicroseconds}");
    print("end - artime ${afterSort.difference(artime).inMicroseconds}");
    // Extract the contents of the Zip archive to disk.
    for (ArchiveFile archiveFile in archiveList) {
      String filename = archiveFile.name;
      print(filename);
      if (archiveFile.isFile) {
//      List<int> data = archiveFile.content;
//      File file = File(_productPath + "/${pID}/instruction_out/" + filename)
//        ..createSync(recursive: true)
//        ..writeAsBytesSync(data);

        if (archiveFile.isCompressed) {
          archiveFile.decompress();
        }
        result.add(MemoryImage(Uint8List.fromList(archiveFile.content)));
//      print("${archiveFile.name} added to list!");
      } else {
//      Directory(_productPath + "/${pID}/instruction_out/" + filename)
//        ..create(recursive: true);
        print("${archiveFile.name} is not FILE!");
      }
    }

    return result;
  }

  int _getPageNumber(String fileName) {
//    print("get page number from $fileName to ${fileName.replaceAll(".jpg", "").substring(0, fileName.length-3)}");
    return int.parse(fileName.substring(0, fileName.length - 7));
  }

  isArchiveExists(String pID) {
    return File(_productPath + "/${pID}/$instructionFileName").existsSync();
  }

  removeInstructionArchive(String pID) {
    var file = File(_productPath + "/${pID}/$instructionFileName");
    file.deleteSync(recursive: true);
  }

  Future init() async {
    // _storageDir = await getApplicationDocumentsDirectory();
    // _productPath = _storageDir.path + "/products";
//    DocumentSnapshot doc = await Firestore.instance.collection("constants").document("passwords").get();
//    _pass = doc["archivePassword"];
    initialized = true;
  }
}
