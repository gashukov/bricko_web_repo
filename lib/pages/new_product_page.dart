import 'package:bricko_web/componets/header.dart';
import 'package:bricko_web/constants.dart';
import 'package:bricko_web/utils/app_data.dart';
import 'package:bricko_web/utils/streams.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddProductForm extends StatefulWidget {
  @override
  AddProductFormState createState() {
    return AddProductFormState();
  }
}

class AddProductFormState extends State<AddProductForm> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _productTitleRuHasError = true;
  bool _productTitleEnHasError = true;
  bool _productDescriptionEnHasError = true;
  bool _productDescriptionRuHasError = true;
  bool _iapIDHasError = true;
  bool _instructionIDHasError = true;
  bool _productAdsPriceHasError = true;
  // bool _genderHasError = false;
  FilePickerResult screensResult;
  FilePickerResult iconResult;
  FilePickerResult archiveResult;

  final ValueChanged _onChanged = (val) => print(val);
  var genderOptions = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * .2,
            right: MediaQuery.of(context).size.width * .2),
        child: Column(
          children: <Widget>[
            SizedBox(height: defaultPadding * 2),
            Header("Новая инструкция", false),
            SizedBox(height: defaultPadding * 2),
            Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: FormBuilder(
                key: _formKey,
                // enabled: false,
                autovalidateMode: AutovalidateMode.disabled,
                // initialValue: {
                //   'movie_rating': 5,
                //   'best_language': 'Dart',
                //   'productTitle_ru': '',
                //   'productTitle_en': '',
                //   'gender': 'Male'
                // },
                skipDisabled: true,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15),
                    // FormBuilderDateTimePicker(
                    //   name: 'date',
                    //   initialValue: DateTime.now(),
                    //   inputType: InputType.time,
                    //   decoration: InputDecoration(
                    //     labelText: 'Appointment Time',
                    //     suffixIcon: IconButton(
                    //         icon: Icon(Icons.close),
                    //         onPressed: () {
                    //           _formKey.currentState.fields['date']
                    //               ?.didChange(null);
                    //         }),
                    //   ),
                    //   initialTime: TimeOfDay(hour: 8, minute: 0),
                    //   locale: Locale.fromSubtags(languageCode: 'fr'),
                    // ),
                    // FormBuilderDateRangePicker(
                    //   name: 'date_range',
                    //   firstDate: DateTime(1970),
                    //   lastDate: DateTime(2030),
                    //   format: DateFormat('yyyy-MM-dd'),
                    //   onChanged: _onChanged,
                    //   decoration: InputDecoration(
                    //     labelText: 'Date Range',
                    //     helperText: 'Helper text',
                    //     hintText: 'Hint text',
                    //     suffixIcon: IconButton(
                    //         icon: Icon(Icons.close),
                    //         onPressed: () {
                    //           _formKey.currentState.fields['date_range']
                    //               ?.didChange(null);
                    //         }),
                    //   ),
                    // ),
                    // FormBuilderSlider(
                    //   name: 'slider',
                    //   validator: FormBuilderValidators.compose([
                    //     FormBuilderValidators.min(context, 6),
                    //   ]),
                    //   onChanged: _onChanged,
                    //   min: 0.0,
                    //   max: 10.0,
                    //   initialValue: 7.0,
                    //   divisions: 20,
                    //   activeColor: Colors.red,
                    //   inactiveColor: Colors.pink[100],
                    //   decoration: const InputDecoration(
                    //     labelText: 'Number of things',
                    //   ),
                    // ),
                    // FormBuilderRangeSlider(
                    //   name: 'range_slider',
                    //   // validator: FormBuilderValidators.compose([FormBuilderValidators.min(context, 6)]),
                    //   onChanged: _onChanged,
                    //   min: 0.0,
                    //   max: 100.0,
                    //   initialValue: RangeValues(4, 7),
                    //   divisions: 20,
                    //   activeColor: Colors.red,
                    //   inactiveColor: Colors.pink[100],
                    //   decoration: const InputDecoration(labelText: 'Price Range'),
                    // ),
                    // FormBuilderCheckbox(
                    //   name: 'accept_terms',
                    //   initialValue: false,
                    //   onChanged: _onChanged,
                    //   title: RichText(
                    //     text: TextSpan(
                    //       children: [
                    //         TextSpan(
                    //           text: 'I have read and agree to the ',
                    //           style: TextStyle(color: Colors.black),
                    //         ),
                    //         TextSpan(
                    //           text: 'Terms and Conditions',
                    //           style: TextStyle(color: Colors.blue),
                    //           // Flutter doesn't allow a button inside a button
                    //           // https://github.com/flutter/flutter/issues/31437#issuecomment-492411086
                    //           /*
                    //           recognizer: TapGestureRecognizer()
                    //             ..onTap = () {
                    //               print('launch url');
                    //             },
                    //           */
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   validator: FormBuilderValidators.equal(
                    //     context,
                    //     true,
                    //     errorText:
                    //         'You must accept terms and conditions to continue',
                    //   ),
                    // ),
                    // НАЗВАНИЕ НА РУССКОМ
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'productTitle_ru',
                      decoration: InputDecoration(
                        labelText: 'Название инструкции на русском',
                        suffixIcon: _productTitleRuHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _productTitleRuHasError = !(_formKey
                                  .currentState?.fields['productTitle_ru']
                                  ?.validate() ??
                              false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.maxLength(context, 70),
                        FormBuilderValidators.minLength(context, 5),
                      ]),
                      // initialValue: '12',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    // НАЗВАНИЕ НА АНГЛИЙСКОМ
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'productTitle_en',
                      decoration: InputDecoration(
                        labelText: 'Название инструкции на английском',
                        suffixIcon: _productTitleEnHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _productTitleEnHasError = !(_formKey
                                  .currentState?.fields['productTitle_en']
                                  ?.validate() ??
                              false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.maxLength(context, 70),
                        FormBuilderValidators.minLength(context, 5),
                      ]),
                      // initialValue: '12',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'instructionID',
                      decoration: InputDecoration(
                        labelText: 'ID инструкции',
                        suffixIcon: _instructionIDHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _instructionIDHasError = !(_formKey
                                  .currentState?.fields['instructionID']
                                  ?.validate() ??
                              false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.maxLength(context, 100),
                        FormBuilderValidators.minLength(context, 1),
                      ]),
                      // initialValue: _formKey
                      //         .currentState?.fields["productTitle_en"].value
                      //         .toString() +
                      //     "_" +
                      //     _formKey.currentState.fields["set"].value.toString(),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    // IAPID
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'iapID',
                      decoration: InputDecoration(
                        labelText: 'IAP ID',
                        suffixIcon: _iapIDHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _iapIDHasError = !(_formKey
                                  .currentState?.fields['iapID']
                                  ?.validate() ??
                              false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.maxLength(context, 152),
                        FormBuilderValidators.minLength(context, 1),
                      ]),
                      // initialValue: '12',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'productAdsPrice',
                      decoration: InputDecoration(
                        labelText: 'Число реклам для разблокировки',
                        suffixIcon: _productAdsPriceHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _productAdsPriceHasError = !(_formKey
                                  .currentState?.fields['productAdsPrice']
                                  ?.validate() ??
                              false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                        FormBuilderValidators.max(context, 15),
                        FormBuilderValidators.min(context, 1),
                      ]),
                      // initialValue: '12',
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),

                    // FormBuilderDropdown<String>(
                    //   // autovalidate: true,
                    //   name: 'gender',
                    //   decoration: InputDecoration(
                    //     labelText: 'Gender',
                    //     suffix: _genderHasError
                    //         ? const Icon(Icons.error)
                    //         : const Icon(Icons.check),
                    //   ),
                    //   // initialValue: 'Male',
                    //   allowClear: true,
                    //   hint: Text('Select Gender'),
                    //   validator: FormBuilderValidators.compose(
                    //       [FormBuilderValidators.required(context)]),
                    //   items: genderOptions
                    //       .map((gender) => DropdownMenuItem(
                    //             value: gender,
                    //             child: Text(gender),
                    //           ))
                    //       .toList(),
                    //   onChanged: (val) {
                    //     setState(() {
                    //       _genderHasError = !(_formKey
                    //               .currentState?.fields['gender']
                    //               ?.validate() ??
                    //           false);
                    //     });
                    //   },
                    //   valueTransformer: (val) => val?.toString(),
                    // ),
                    // FormBuilderRadioGroup<String>(
                    //   decoration: const InputDecoration(
                    //     labelText: 'My chosen language',
                    //   ),
                    //   initialValue: null,
                    //   name: 'best_language',
                    //   onChanged: _onChanged,
                    //   validator: FormBuilderValidators.compose(
                    //       [FormBuilderValidators.required(context)]),
                    //   options: ['Dart', 'Kotlin', 'Java', 'Swift', 'Objective-C']
                    //       .map((lang) => FormBuilderFieldOption(
                    //             value: lang,
                    //             child: Text(lang),
                    //           ))
                    //       .toList(growable: false),
                    //   controlAffinity: ControlAffinity.trailing,
                    // ),
                    // FormBuilderSegmentedControl(
                    //   decoration: const InputDecoration(
                    //     labelText: 'Movie Rating (Archer)',
                    //   ),
                    //   name: 'movie_rating',
                    //   // initialValue: 1,
                    //   // textStyle: TextStyle(fontWeight: FontWeight.bold),
                    //   options: List.generate(5, (i) => i + 1)
                    //       .map((number) => FormBuilderFieldOption(
                    //             value: number,
                    //             child: Text(
                    //               number.toString(),
                    //               style: const TextStyle(
                    //                   fontWeight: FontWeight.bold),
                    //             ),
                    //           ))
                    //       .toList(),
                    //   onChanged: _onChanged,
                    // ),
                    // FormBuilderSwitch(
                    //   title: const Text('I Accept the tems and conditions'),
                    //   name: 'accept_terms_switch',
                    //   initialValue: true,
                    //   onChanged: _onChanged,
                    // ),

                    FormBuilderCheckboxGroup(
                      decoration: const InputDecoration(
                        labelText: 'Выберите категории',
                        labelStyle: TextStyle(fontSize: 22),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: defaultPadding),
                      ),

                      name: 'categories',
                      // initialValue: const ['Dart'],
                      options: categoriesSnapshots
                          .map((s) => FormBuilderFieldOption(
                              child: Text(s.data()[setCatTitle +
                                  Localizations.localeOf(context)
                                      .languageCode
                                      .toLowerCase()]),
                              value: s.id))
                          .toList(),
                      onChanged: _onChanged,
                      // separator: const VerticalDivider(
                      //   width: 10,
                      //   thickness: 5,
                      //   color: Colors.red,
                      // ),
                    ),
                    FormBuilderRadioGroup<String>(
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 22),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: defaultPadding),
                        labelText: 'Выберите набор',
                      ),
                      initialValue: null,
                      name: 'set',
                      onChanged: _onChanged,
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required(context)]),
                      options: setsSnapshots
                          .map((s) => FormBuilderFieldOption(
                              child: Text(s.data()[setCatTitle +
                                  Localizations.localeOf(context)
                                      .languageCode
                                      .toLowerCase()]),
                              value: s.id))
                          .toList(),
                      controlAffinity: ControlAffinity.trailing,
                      // separator: const VerticalDivider(
                      //   width: 10,
                      //   thickness: 5,
                      //   color: Colors.red,
                      // ),
                    ),
                    FormBuilderRadioGroup<String>(
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 22),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: defaultPadding),
                        labelText: 'Способ распространения',
                      ),
                      initialValue: "free",
                      name: 'productPriceType',
                      onChanged: _onChanged,
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required(context)]),
                      options: const [
                        FormBuilderFieldOption(
                            value: 'ads', child: Text("Реклама")),
                        FormBuilderFieldOption(
                            value: 'paid', child: Text("Продажа")),
                        FormBuilderFieldOption(
                            value: 'free', child: Text("Бесплатно")),
                      ],
                      controlAffinity: ControlAffinity.trailing,
                      // separator: const VerticalDivider(
                      //   width: 10,
                      //   thickness: 5,
                      //   color: Colors.red,
                      // ),
                    ),

                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'productDescription_ru',
                      decoration: InputDecoration(
                        labelText: 'Описание инструкции на русском',
                        suffixIcon: _productDescriptionRuHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _productDescriptionRuHasError = !(_formKey
                                  .currentState?.fields['productDescription_ru']
                                  ?.validate() ??
                              false);
                        });
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.maxLength(context, 3000),
                        FormBuilderValidators.minLength(context, 5),
                      ]),
                      expands: false,
                      minLines: 1,
                      maxLines: 50,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.next,
                    ),

                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'productDescription_en',
                      decoration: InputDecoration(
                        labelText: 'Описание инструкции на английском',
                        suffixIcon: _productDescriptionEnHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _productDescriptionEnHasError = !(_formKey
                                  .currentState?.fields['productDescription_en']
                                  ?.validate() ??
                              false);
                        });
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.maxLength(context, 3000),
                        FormBuilderValidators.minLength(context, 5),
                      ]),
                      expands: false,
                      minLines: 1,
                      maxLines: 50,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.next,
                    ),

                    FormBuilderSwitch(
                      title: const Text('Отображать пользователю'),
                      name: 'productActive',
                      initialValue: true,
                      onChanged: _onChanged,
                    ),

                    FormBuilderField(
                      name: "icon",
                      onChanged: (val) {
                        setState(() {
                          print(val.name);
                        });
                      },
                      validator: FormBuilderValidators.required(context),
                      builder: (FormFieldState<dynamic> field) {
                        return Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: ElevatedButton.icon(
                              onPressed: () async {
                                iconResult = null;
                                iconResult =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.image,
                                  allowMultiple: false,
                                  // allowedExtensions: ['jpg', 'pdf', 'doc'],
                                );
                                if (iconResult != null) {
                                  field.didChange(iconResult.files[0]);
                                }
                              },
                              icon: Icon(Icons.image),
                              label: Text("Загрузить иконку")),
                        );
                      },
                    ),

                    Container(
                      height: iconResult == null ? 0 : 48,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: iconResult == null ? 0 : 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Chip(
                              elevation: 4.0,
                              label: Text(iconResult.files[index].name),
                            ),
                          );
                        },
                      ),
                    ),

                    FormBuilderField(
                      name: "screens",
                      validator: FormBuilderValidators.required(context),
                      onChanged: (val) {
                        setState(() {
                          for (PlatformFile file in val) {
                            print(file.name);
                          }
                        });
                      },
                      builder: (FormFieldState<dynamic> field) {
                        return Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: ElevatedButton.icon(
                              onPressed: () async {
                                screensResult = null;
                                screensResult =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.image,
                                  allowMultiple: true,
                                  // allowedExtensions: ['jpg', 'pdf', 'doc'],
                                );
                                if (screensResult != null) {
                                  field.didChange(screensResult.files);
                                }
                              },
                              icon: Icon(Icons.add),
                              label: Text("Загрузить изображения для превью")),
                        );
                      },
                    ),

                    Container(
                      height: screensResult == null ? 0 : 48,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: screensResult == null
                            ? 0
                            : screensResult.files.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Chip(
                              elevation: 4.0,
                              label: Text(screensResult.files[index].name),
                            ),
                          );
                        },
                      ),
                    ),

                    FormBuilderField(
                      name: "archive",
                      validator: FormBuilderValidators.required(context),
                      onChanged: (val) {
                        setState(() {
                          print(val.name);
                        });
                      },
                      builder: (FormFieldState<dynamic> field) {
                        return Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: ElevatedButton.icon(
                              onPressed: () async {
                                archiveResult = null;
                                archiveResult =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowMultiple: false,
                                  allowedExtensions: ['zip'],
                                );
                                if (archiveResult != null) {
                                  field.didChange(archiveResult.files[0]);
                                }
                              },
                              icon: Icon(Icons.archive),
                              label: Text("Загрузить архив со слайдами")),
                        );
                      },
                    ),

                    Container(
                      height: archiveResult == null ? 0 : 48,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: archiveResult == null ? 0 : 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Chip(
                              elevation: 4.0,
                              label: Text(archiveResult.files[index].name),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton.icon(
                    // padding: EdgeInsets.all(defaultPadding),
                    onPressed: () {
                      _formKey.currentState?.reset();
                    
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.orange),
                    icon: Icon(Icons.clear),
                    label: Text("Сбросить"),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    // padding: EdgeInsets.all(defaultPadding),
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        print(_formKey.currentState?.value);
                      } else {
                        print(_formKey.currentState?.value);
                        print('validation failed');
                      }
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    icon: Icon(Icons.done),
                    label: Text("Создать"),
                  ),

                  // Expanded(
                  //   child: OutlinedButton(
                  //     onPressed: () {
                  //       _formKey.currentState?.reset();
                  //     },
                  //     // color: Theme.of(context).colorScheme.secondary,
                  //     child: Text(
                  //       'Reset',
                  //       style: TextStyle(color: Colors.blueAccent),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
