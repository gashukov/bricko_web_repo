import 'dart:math';

import 'package:bricko_web/helpers/constants.dart';
import 'package:bricko_web/models/brands.dart';
import 'package:bricko_web/models/categories.dart';
import 'package:bricko_web/models/orders.dart';
import 'package:bricko_web/models/products.dart';
import 'package:bricko_web/models/user.dart';
import 'package:bricko_web/services/brands.dart';
import 'package:bricko_web/services/categories.dart';
import 'package:bricko_web/services/orders.dart';
import 'package:bricko_web/services/products.dart';
import 'package:bricko_web/services/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_table/DatatableHeader.dart';

class TablesProvider with ChangeNotifier {
  // ANCHOR table headers
  List<DatatableHeader> usersTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Name",
        value: "name",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Email",
        value: "email",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  List<DatatableHeader> ordersTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: false,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "User Id",
        value: "userId",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Description",
        value: "description",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Created At",
        value: "createdAt",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Total",
        value: "total",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  List<DatatableHeader> productsTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: false,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Name",
        value: "name",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Brand",
        value: "brand",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Category",
        value: "category",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Quantity",
        value: "quantity",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Sizes",
        value: "sizes",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Colors",
        value: "colors",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Featured",
        value: "featured",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Sale",
        value: "sale",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Price",
        value: "price",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  List<DatatableHeader> brandsTableHeader = [
    DatatableHeader(
        text: "Title EN",
        value: "titleEn",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Title RU",
        value: "titleRu",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  List<DatatableHeader> categoriesTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Category",
        value: "category",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
  ];
  List<int> perPages = [5, 10, 15, 100];
  int total = 100;
  int currentPerPage;
  int currentPage = 1;
  bool isSearch = false;
  List<Map<String, dynamic>> usersTableSource = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> ordersTableSource = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> productsTableSource = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> categoriesTableSource =
      List<Map<String, dynamic>>();
  List<Map<String, dynamic>> brandsTableSource = List<Map<String, dynamic>>();

  List<Map<String, dynamic>> selecteds = List<Map<String, dynamic>>();
  String selectableKey = "id";

  String sortColumn;
  bool sortAscending = true;
  bool isLoading = true;
  bool showSelect = true;

  UserServices _userServices = UserServices();
  List<UserModel> _users = <UserModel>[];
  List<UserModel> get users => _users;

  OrderServices _orderServices = OrderServices();
  List<OrderModel> _orders = <OrderModel>[];
  List<OrderModel> get orders => _orders;

  ProductsServices _productsServices = ProductsServices();
  List<ProductModel> _products = <ProductModel>[];
  List<ProductModel> get products => _products;

  CategoriesServices _categoriesServices = CategoriesServices();
  List<CategoriesModel> _categories = <CategoriesModel>[];

  BrandsServices _brandsServices = BrandsServices();
  List<BrandModel> _brands = <BrandModel>[];

  Future _loadFromFirebase() async {
    print("загружаем данные таблиц с фаербейс");
    // _users = await _userServices.getAllUsers();
    // _orders = await _orderServices.getAllOrders();
    // _products = await _productsServices.getAllProducts();
    _brands = await _brandsServices.getAll();
    // _categories = await _categoriesServices.getAll();
  }

  List<Map<String, dynamic>> _getUsersData() {
    isLoading = true;
    notifyListeners();
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    var i = _users.length;
    print(i);
    for (UserModel userData in _users) {
      temps.add({
        "id": userData.id,
        "email": userData.email,
        "name": userData.name,
      });
      i++;
    }
    isLoading = false;
    notifyListeners();
    return temps;
  }

  List<Map<String, dynamic>> _getBrandsData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    for (BrandModel brand in _brands) {
      temps.add({
        "titleEn": brand.titleEn,
        "titleRu": brand.titleRu,
      });
    }
    return temps;
  }

  List<Map<String, dynamic>> _getCategoriesData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();

    for (CategoriesModel category in _categories) {
      temps.add({
        "titleEn": category.titleEn,
        "titleRu": category.titleRu,
      });
    }
    return temps;
  }

  List<Map<String, dynamic>> _getOrdersData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    for (OrderModel order in _orders) {
      temps.add({
        "id": order.id,
        "userId": order.userId,
        "description": order.description,
        "createdAt": DateFormat.yMMMd()
            .format(DateTime.fromMillisecondsSinceEpoch(order.createdAt)),
        "total": "\$${order.total}",
      });
    }
    return temps;
  }

  List<Map<String, dynamic>> _getProductsData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    for (ProductModel product in _products) {
      temps.add({
        "active": product.active,
        "pSet": product.pSet,
        "titleEn": product.titleEn,
        "titleRu": product.titleRu,
        "descriptionEn": product.descriptionEn,
        "descriptionRu": product.descriptionRu,
        "priceType": product.priceType,
        "iapID": product.iapID,
        "adsPrice": product.adsPrice,
        "categories": product.categories,
        "screensCount": product.screensCount,
      });
    }
    return temps;
  }

  _initData() async {
    isLoading = true;
    notifyListeners();

    await initialization.then((value) {
      auth.authStateChanges().listen(_onStateChanged);
    });
  }

  _onStateChanged(User firebaseUser) async {
    //todo проверка че за юзер
    print("состояние изменено user " + firebaseUser.email);
    if (firebaseUser.email == "mashukovg@gmail.com") {
      await _loadFromFirebase();
      // usersTableSource.addAll(_getUsersData());
      // ordersTableSource.addAll(_getOrdersData());
      // productsTableSource.addAll(_getProductsData());
      // categoriesTableSource.addAll(_getCategoriesData());
      brandsTableSource.addAll(_getBrandsData());

      isLoading = false;
      notifyListeners();
    }
  }

  onSort(dynamic value) {
    sortColumn = value;
    sortAscending = !sortAscending;
    if (sortAscending) {
      usersTableSource
          .sort((a, b) => b["$sortColumn"].compareTo(a["$sortColumn"]));
    } else {
      usersTableSource
          .sort((a, b) => a["$sortColumn"].compareTo(b["$sortColumn"]));
    }
    notifyListeners();
  }

  onSelected(bool value, Map<String, dynamic> item) {
    print("$value  $item ");
    if (value) {
      selecteds.add(item);
    } else {
      selecteds.removeAt(selecteds.indexOf(item));
    }
    notifyListeners();
  }

  onSelectAll(bool value) {
    if (value) {
      selecteds = usersTableSource.map((entry) => entry).toList().cast();
    } else {
      selecteds.clear();
    }
    notifyListeners();
  }

  onChanged(int value) {
    currentPerPage = value;
    notifyListeners();
  }

  previous() {
    currentPage = currentPage >= 2 ? currentPage - 1 : 1;
    notifyListeners();
  }

  next() {
    currentPage++;
    notifyListeners();
  }

  TablesProvider.init() {
    print("TablesProvider init start");

    _initData();
  }
}
