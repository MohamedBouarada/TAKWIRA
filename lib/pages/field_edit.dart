import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takwira_mobile/models/field_model.dart';

import '../providers/fields.dart';

class EditFieldList extends StatefulWidget {
  static const routeName = '/edit-field';

  @override
  _EditFieldListState createState() => _EditFieldListState();
}

class _EditFieldListState extends State<EditFieldList> {
  final _adresseFocusNode = FocusNode();
  final _typeFocusNode = FocusNode();
  final _isNotAvailableFocusNode = FocusNode();
  final _servicesFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _periodFocusNode = FocusNode();
  final _surfaceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedField = FieldModel(
    id: -1,
    name: '',
    adresse: '',
    type: '',
    isNotAvailable: '',
    services: '',
    price: 0.0,
    period: '',
    surface: '',
    description: '',
    idProprietaire: 1,
  );
  var _initValues = {
    'name': '',
    'adresse': '',
    'type': '',
    'isNotAvailable': '',
    'services': '',
    'price': '',
    'period': '',
    'surface': '',
    'description': '',
    'idProprietaire': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final fieldId = ModalRoute.of(context)!.settings.arguments as int;
      print(fieldId);
      if (fieldId != -1) {
        _editedField =
            Provider.of<Fields>(context, listen: false).findById(fieldId);
        _initValues = {
          'name': _editedField.name,
          'adresse': _editedField.adresse,
          'type': _editedField.type,
          'isNotAvailable': _editedField.isNotAvailable,
          'services': _editedField.services,
          'price': _editedField.price.toString(),
          'period': _editedField.period,
          'surface': _editedField.surface,
          'description': _editedField.description,
          'idProprietaire': _editedField.idProprietaire.toString(),
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _adresseFocusNode.dispose();
    _typeFocusNode.dispose();
    _isNotAvailableFocusNode.dispose();
    _servicesFocusNode.dispose();
    _priceFocusNode.dispose();
    _surfaceFocusNode.dispose();

    _periodFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  // void _updateImageUrl() {
  //   if (!_imageUrlFocusNode.hasFocus) {
  //     if ((!_imageUrlController.text.startsWith('http') &&
  //             !_imageUrlController.text.startsWith('https')) ||
  //         (!_imageUrlController.text.endsWith('.png') &&
  //             !_imageUrlController.text.endsWith('.jpg') &&
  //             !_imageUrlController.text.endsWith('.jpeg'))) {
  //       return;
  //     }
  //     setState(() {});
  //   }
  // }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedField.id != -1) {
      await Provider.of<Fields>(context, listen: false)
          .updateField(_editedField.id, _editedField);
    } else {
      try {
        await Provider.of<Fields>(context, listen: false)
            .addField(_editedField);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('An error occurred!'),
            content: const Text('Something went wrong.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Field'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['name'],
                      decoration: InputDecoration(labelText: 'Name'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_adresseFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedField = FieldModel(
                          id: _editedField.id,
                          name: value!,
                          adresse: _editedField.adresse,
                          type: _editedField.type,
                          isNotAvailable: _editedField.isNotAvailable,
                          services: _editedField.services,
                          price: _editedField.price,
                          period: _editedField.period,
                          surface: _editedField.surface,
                          description: _editedField.description,
                          idProprietaire: _editedField.idProprietaire,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['adresse'],
                      decoration: InputDecoration(labelText: 'Adresse'),
                      textInputAction: TextInputAction.next,
                      focusNode: _adresseFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_typeFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedField = FieldModel(
                          id: _editedField.id,
                          name: _editedField.name,
                          adresse: value!,
                          type: _editedField.type,
                          isNotAvailable: _editedField.isNotAvailable,
                          services: _editedField.services,
                          price: _editedField.price,
                          period: _editedField.period,
                          surface: _editedField.surface,
                          description: _editedField.description,
                          idProprietaire: _editedField.idProprietaire,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['type'],
                      decoration: InputDecoration(labelText: 'Type'),
                      textInputAction: TextInputAction.next,
                      focusNode: _typeFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_isNotAvailableFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedField = FieldModel(
                          id: _editedField.id,
                          name: _editedField.name,
                          adresse: _editedField.adresse,
                          type: value!,
                          isNotAvailable: _editedField.isNotAvailable,
                          services: _editedField.services,
                          price: _editedField.price,
                          period: _editedField.period,
                          surface: _editedField.surface,
                          description: _editedField.description,
                          idProprietaire: _editedField.idProprietaire,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['isNotAvailable'],
                      decoration: InputDecoration(labelText: 'isNotAvailable'),
                      textInputAction: TextInputAction.next,
                      focusNode: _isNotAvailableFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_servicesFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedField = FieldModel(
                          id: _editedField.id,
                          name: _editedField.name,
                          adresse: _editedField.adresse,
                          type: _editedField.type,
                          isNotAvailable: value!,
                          services: _editedField.services,
                          price: _editedField.price,
                          period: _editedField.period,
                          surface: _editedField.surface,
                          description: _editedField.description,
                          idProprietaire: _editedField.idProprietaire,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['services'],
                      decoration: InputDecoration(labelText: 'Services'),
                      textInputAction: TextInputAction.next,
                      focusNode: _servicesFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedField = FieldModel(
                          id: _editedField.id,
                          name: _editedField.name,
                          adresse: _editedField.adresse,
                          type: _editedField.type,
                          isNotAvailable: _editedField.isNotAvailable,
                          services: value!,
                          price: _editedField.price,
                          period: _editedField.period,
                          surface: _editedField.surface,
                          description: _editedField.description,
                          idProprietaire: _editedField.idProprietaire,
                        );
                      },
                    ),

                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_periodFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a price.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater than zero.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedField = FieldModel(
                          id: _editedField.id,
                          name: _editedField.name,
                          adresse: _editedField.adresse,
                          type: _editedField.type,
                          isNotAvailable: _editedField.isNotAvailable,
                          services: _editedField.services,
                          price: double.parse(value!),
                          period: _editedField.period,
                          surface: _editedField.surface,
                          description: _editedField.description,
                          idProprietaire: _editedField.idProprietaire,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['period'],
                      decoration: InputDecoration(labelText: 'Period'),
                      textInputAction: TextInputAction.next,
                      focusNode: _periodFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_surfaceFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedField = FieldModel(
                          id: _editedField.id,
                          name: _editedField.name,
                          adresse: _editedField.adresse,
                          type: _editedField.type,
                          isNotAvailable: _editedField.isNotAvailable,
                          services: _editedField.services,
                          price: _editedField.price,
                          period: value!,
                          surface: _editedField.surface,
                          description: _editedField.description,
                          idProprietaire: _editedField.idProprietaire,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['surface'],
                      decoration: InputDecoration(labelText: 'Surface'),
                      textInputAction: TextInputAction.next,
                      focusNode: _surfaceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedField = FieldModel(
                          id: _editedField.id,
                          name: _editedField.name,
                          adresse: _editedField.adresse,
                          type: _editedField.type,
                          isNotAvailable: _editedField.isNotAvailable,
                          services: _editedField.services,
                          price: _editedField.price,
                          period: _editedField.period,
                          surface: value!,
                          description: _editedField.description,
                          idProprietaire: _editedField.idProprietaire,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description.';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedField = FieldModel(
                          id: _editedField.id,
                          name: _editedField.name,
                          adresse: _editedField.adresse,
                          type: _editedField.type,
                          isNotAvailable: _editedField.isNotAvailable,
                          services: _editedField.services,
                          price: _editedField.price,
                          period: _editedField.period,
                          surface: _editedField.surface,
                          description: value!,
                          idProprietaire: _editedField.idProprietaire,
                        );
                      },
                    ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: <Widget>[
                    //     Container(
                    //       width: 100,
                    //       height: 100,
                    //       margin: EdgeInsets.only(
                    //         top: 8,
                    //         right: 10,
                    //       ),
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //           width: 1,
                    //           color: Colors.grey,
                    //         ),
                    //       ),
                    //       child: _imageUrlController.text.isEmpty
                    //           ? Text('Enter a URL')
                    //           : FittedBox(
                    //               child: Image.network(
                    //                 _imageUrlController.text,
                    //                 fit: BoxFit.cover,
                    //               ),
                    //             ),
                    //     ),
                    //     Expanded(
                    //       child: TextFormField(
                    //         decoration: InputDecoration(labelText: 'Image URL'),
                    //         keyboardType: TextInputType.url,
                    //         textInputAction: TextInputAction.done,
                    //         controller: _imageUrlController,
                    //         focusNode: _imageUrlFocusNode,
                    //         onFieldSubmitted: (_) {
                    //           _saveForm();
                    //         },
                    //         validator: (value) {
                    //           if (value.isEmpty) {
                    //             return 'Please enter an image URL.';
                    //           }
                    //           if (!value.startsWith('http') &&
                    //               !value.startsWith('https')) {
                    //             return 'Please enter a valid URL.';
                    //           }
                    //           if (!value.endsWith('.png') &&
                    //               !value.endsWith('.jpg') &&
                    //               !value.endsWith('.jpeg')) {
                    //             return 'Please enter a valid image URL.';
                    //           }
                    //           return null;
                    //         },
                    //         onSaved: (value) {
                    //           _editedField = Product(
                    //             title: _editedField.title,
                    //             price: _editedField.price,
                    //             description: _editedField.description,
                    //             imageUrl: value,
                    //             id: _editedField.id,
                    //             isFavorite: _editedField.isFavorite,
                    //           );
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}



// // ignore_for_file: prefer_const_constructors, deprecated_member_use

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:takwira_mobile/screens/owner_field_list.dart';
// import '../models/field_model.dart';
// import '../services/api_service.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:snippet_coder_utils/FormHelper.dart';
// import 'package:snippet_coder_utils/ProgressHUD.dart';
// import 'package:snippet_coder_utils/hex_color.dart';

// import '../config.dart';

// class FieldAddEdit extends StatefulWidget {
//   const FieldAddEdit({Key? key}) : super(key: key);
  
//   @override
//   _FieldAddEditState createState() => _FieldAddEditState();
// }

// class _FieldAddEditState extends State<FieldAddEdit> {
//   FieldModel? fieldModel;
//   static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
//   bool isApiCallProcess = false;
//   List<Object> images = [];
//   bool isEditMode = false;
//   bool isImageSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//          elevation: 0,
//         brightness: Brightness.light,
//         backgroundColor: Color(0x665ac18e),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => IndexPage()));
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             size: 20,
//             color: Colors.black,
//           ),
//         ),
//       ),
//         backgroundColor: Colors.grey[200],
//         body: ProgressHUD(
//           child: Form(
//             key: globalFormKey,
//             child: FieldForm(),
//           ),
//           inAsyncCall: isApiCallProcess,
//           opacity: 0.3,
//           key: UniqueKey(),
//         ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     fieldModel = FieldModel();

//     Future.delayed(Duration.zero, () {
//       if (ModalRoute.of(context)?.settings.arguments != null) {
//         final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
//         fieldModel = arguments['model'];
//         isEditMode = true;
//         setState(() {});
//       }
//     });
//   }

//   Widget FieldForm() {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(
//               bottom: 10,
//               top: 10,
//             ),
//             child: FormHelper.inputFieldWidget(
//               context,
//               "FieldName",
//               "Field Name",
//               (onValidateVal) {
//                 if (onValidateVal.isEmpty) {
//                   return 'FieldName can\'t be empty.';
//                 }

//                 return null;
//               },
//               (onSavedVal) => {
//                 fieldModel!.name = onSavedVal,
//               },
//               initialValue: fieldModel!.name ?? "",
//               obscureText: false,
//               borderFocusColor: Colors.black,
//               borderColor: Colors.black,
//               textColor: Colors.black,
//               hintColor: Colors.black.withOpacity(0.7),
//               borderRadius: 10,
//               showPrefixIcon: false,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//               bottom: 10,
//               top: 10,
//             ),
//             child: FormHelper.inputFieldWidget(
//               context,
              
//               "FieldPrice",
//               "Field Price",
//               (onValidateVal) {
//                 if (onValidateVal.isEmpty) {
//                   return 'Field Price can\'t be empty.';
//                 }

//                 return null;
//               },
//               (onSavedVal) => {
//                 fieldModel!.prix = double.parse(onSavedVal),
//               },
//               initialValue: fieldModel!.prix == null
//                   ? ""
//                   : fieldModel!.prix.toString(),
//               obscureText: false,
//               borderFocusColor: Colors.black,
//               borderColor: Colors.black,
//               textColor: Colors.black,
//               hintColor: Colors.black.withOpacity(0.7),
//               borderRadius: 10,
//               showPrefixIcon: false,
//               suffixIcon: const Icon(Icons.monetization_on),
//             ),
//           ),
         
//           const SizedBox(
//             height: 20,
//           ),
//           Center(
//             child: FormHelper.submitButton(
//               "Save",
//               () {
//                 if (validateAndSave()) {
//                   print(fieldModel!.toJson());

//                   setState(() {
//                     isApiCallProcess = true;
//                   });

//                   APIService.saveField(
//                     fieldModel!,
//                     isEditMode,
//                     isImageSelected,
//                   ).then(
//                     (response) {
//                       setState(() {
//                         isApiCallProcess = false;
//                       });

//                       if (response) {
//                         Navigator.pushNamedAndRemoveUntil(
//                           context,
//                           '/',
//                           (route) => false,
//                         );
//                       } else {
//                         FormHelper.showSimpleAlertDialog(
//                           context,
//                           Config.appName,
//                           "Error occur",
//                           "OK",
//                           () {
//                             Navigator.of(context).pop();
//                           },
//                         );
//                       }
//                     },
//                   );
//                 }
//               },
//               btnColor: HexColor("283B71"),
//               borderColor: Colors.white,
//               txtColor: Colors.white,
//               borderRadius: 10,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//         ],
//       ),
//     );
//   }

//   bool validateAndSave() {
//     final form = globalFormKey.currentState;
//     if (form!.validate()) {
//       form.save();
//       return true;
//     }
//     return false;
//   }

//   // static Widget picPicker(
//   //   bool isImageSelected,
//   //   String fileName,
//   //   Function onFilePicked,
//   // ) {
//   //   Future<XFile?> _imageFile;
//   //   ImagePicker _picker = ImagePicker();

//   //   return Column(
//   //     children: [
//   //       fileName.isNotEmpty
//   //           ? isImageSelected
//   //               ? Image.file(
//   //                   File(fileName),
//   //                   width: 300,
//   //                   height: 300,
//   //                 )
//   //               : SizedBox(
//   //                   child: Image.network(
//   //                     fileName,
//   //                     width: 200,
//   //                     height: 200,
//   //                     fit: BoxFit.scaleDown,
//   //                   ),
//   //                 )
//   //           : SizedBox(
//   //               child: Image.network(
//   //                 "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
//   //                 width: 200,
//   //                 height: 200,
//   //                 fit: BoxFit.scaleDown,
//   //               ),
//   //             ),
//   //       Row(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: [
//   //           SizedBox(
//   //             height: 35.0,
//   //             width: 35.0,
//   //             child: IconButton(
//   //               padding: const EdgeInsets.all(0),
//   //               icon: const Icon(Icons.image, size: 35.0),
//   //               onPressed: () {
//   //                 _imageFile = _picker.pickImage(source: ImageSource.gallery);
//   //                 _imageFile.then((file) async {
//   //                   onFilePicked(file);
//   //                 });
//   //               },
//   //             ),
//   //           ),
//   //           SizedBox(
//   //             height: 35.0,
//   //             width: 35.0,
//   //             child: IconButton(
//   //               padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//   //               icon: const Icon(Icons.camera, size: 35.0),
//   //               onPressed: () {
//   //                 _imageFile = _picker.pickImage(source: ImageSource.camera);
//   //                 _imageFile.then((file) async {
//   //                   onFilePicked(file);
//   //                 });
//   //               },
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ],
//   //   );
//   // }

//   isValidURL(url) {
//     return Uri.tryParse(url)?.hasAbsolutePath ?? false;
//   }
// }