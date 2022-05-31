// ignore_for_file: import_of_legacy_library_into_null_safe, use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, avoid_print, unused_field

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:takwira_mobile/providers/field.dart';
import 'package:takwira_mobile/models/http_exception.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:takwira_mobile/screens/owner_field_list.dart';

class FieldEdit extends StatefulWidget {
  final int id;
  final String name;
  final String type;
  final String address;
  final String prix;
  final String unavailabilityStartDate;
  final String unavailabilityFinishDate;
  final String services;
  final String surface;
  final String period;
  final String description;
  final String opening;
  final String closing;
  final String location;
  final String images;

  const FieldEdit({
    Key? key,
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.prix,
    required this.unavailabilityStartDate,
    required this.unavailabilityFinishDate,
    required this.description,
    required this.services,
    required this.period,
    required this.surface,
    required this.opening,
    required this.closing,
    required this.location,
    required this.images,
  }) : super(key: key);
  @override
  _FieldEditState createState() => _FieldEditState();
}

class _FieldEditState extends State<FieldEdit> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EditCard(
      id: widget.id,
      name: widget.name,
      type: widget.type,
      address: widget.address,
      prix: widget.prix,
      unavailabilityStartDate: widget.unavailabilityStartDate,
      unavailabilityFinishDate: widget.unavailabilityFinishDate,
      description: widget.description,
      services: widget.services,
      period: widget.period,
      surface: widget.surface,
      opening: widget.opening,
      closing: widget.closing,
      location: widget.location,
      images: widget.images,
    );
  }
}

class EditCard extends StatefulWidget {
  final int id;
  final String name;
  final String type;
  final String address;
  final String prix;
  final String unavailabilityStartDate;
  final String unavailabilityFinishDate;
  final String services;
  final String period;
  final String surface;
  final String description;
  final String opening;
  final String closing;
  final String location;
  final String images;

  const EditCard({
    Key? key,
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.prix,
    required this.unavailabilityStartDate,
    required this.unavailabilityFinishDate,
    required this.description,
    required this.services,
    required this.period,
    required this.surface,
    required this.opening,
    required this.closing,
    required this.location,
    required this.images,
  }) : super(key: key);

  @override
  _EditCardState createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
  List<XFile>? _imageFileList;
  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
    if (_imageFileList!.length > 0) {
      fieldImages.add(File(_imageFileList![0].path));
    }
    print(fieldImages[0].path);
    print(fieldImages);
  }

  dynamic _pickImageError;
  bool isVideo = false;

  // VideoPlayerController? _controller;
  // VideoPlayerController? _toBeDisposed;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  Future<void> _onImageButtonPressed(ImageSource source,
      {bool isMultiImage = false}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 100,
      );
      setState(() {
        _setImageFileListFromFile(pickedFile);
        // print("eezzzzzdzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
        // print(fieldImages);
      });

      try {
        await Provider.of<Field>(context, listen: false).addImage(
          id: widget.id,
          fieldImages: fieldImages,
        );
        setState(() {
          fetchImages();
        });
      } on HttpException catch (error) {
        _showErrorDialog(error.toString());
      } catch (error) {
        print(error.toString());
        _showErrorDialog(error.toString());
      }
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  List surfaces = [];
  final Map<String, String> _dates = {"startDate": "", "finishDate": ""};
  bool _displayAvailibilityFields = false;

  late TextEditingController _nameController;
  late TextEditingController _typeController;
  late TextEditingController _addressController;
  late TextEditingController _prixController;
  late TextEditingController _periodController;
  late TextEditingController _unavailabilityStartDateController;
  late TextEditingController _unavailabilityFinishDateController;
  late TextEditingController _descriptionController;
  late TextEditingController _servicesController;
  late TextEditingController _surfaceController;
  late TextEditingController _openingController;
  late TextEditingController _closingController;
  late TextEditingController _locationController;

  final GlobalKey<FormState> _formKey = GlobalKey();
  Future<void> getFieldInformation() async {
    _nameController = TextEditingController(text: widget.name);
    _typeController = TextEditingController(text: widget.type);
    _addressController = TextEditingController(text: widget.address);
    _periodController = TextEditingController(text: widget.period);
    _prixController = TextEditingController(text: widget.prix);
    _unavailabilityStartDateController =
        TextEditingController(text: widget.unavailabilityStartDate);
    _unavailabilityFinishDateController =
        TextEditingController(text: widget.unavailabilityFinishDate);
    _descriptionController = TextEditingController(text: widget.description);
    _servicesController = TextEditingController(text: widget.services);
    _surfaceController = TextEditingController(text: widget.surface);
    _openingController = TextEditingController(text: widget.opening);
    _closingController = TextEditingController(text: widget.closing);
    _locationController = TextEditingController(text: widget.location);
  }

  void handleShowSurfaces() {
    if (widget.type == "TENNIS") {
      setState(() {
        surfaces = ["GREEN SET", "RESIN", "GAZON HYBRIDE", "TERRE BATTUE"];
      });
    } else if (widget.type == "FOOTBALL") {
      setState(() {
        surfaces = ["NATURAL GRASS", "ARTIFICIAL SURFACE", "HYBRID TURF"];
      });
    } else {
      setState(() {
        surfaces = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.fetchImages();
    print(photos);
    getFieldInformation();
    handleShowSurfaces();
    print(widget.unavailabilityStartDate);
    _dates['startDate'] = _unavailabilityStartDateController.text.toString();
    _dates['finishDate'] = _unavailabilityFinishDateController.text.toString();
  }

  @override
  void dispose() {
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();

    _nameController.clear();
    _typeController.clear();
    _addressController.clear();
    _prixController.clear();
    _unavailabilityStartDateController.clear();
    _unavailabilityStartDateController.clear();
    _descriptionController.clear();
    _servicesController.clear();
    _surfaceController.clear();
    _periodController.clear();
    _openingController.clear();
    _closingController.clear();
    _locationController.clear();

    _periodController.dispose();
    _nameController.dispose();
    _typeController.dispose();
    _addressController.dispose();
    _prixController.dispose();
    _unavailabilityStartDateController.dispose();
    _unavailabilityStartDateController.dispose();
    _descriptionController.dispose();
    _servicesController.dispose();
    _surfaceController.dispose();
    _openingController.dispose();
    _closingController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  List<File> fieldImages = [];
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    var f = _formKey.currentState;
    if (f != null && !f.validate()) {
      return;
    }
    _formKey.currentState!.save();
    _dates['startDate'] = _unavailabilityStartDateController.text.toString();
    _dates['finishDate'] = _unavailabilityFinishDateController.text.toString();
    print(_dates);
    try {
      await Provider.of<Field>(context, listen: false).update(
        id: widget.id,
        name: _nameController.text.toString(),
        adresse: _addressController.text.toString(),
        type: _typeController.text.toString(),
        isNotAvailable: _dates,
        services: _servicesController.text.toString(),
        price: double.parse(_prixController.text.toString()),
        period: _periodController.text.toString(),
        opening: _openingController.text.toString(),
        closing: _closingController.text.toString(),
        surface: _surfaceController.text.toString(),
        description: _descriptionController.text.toString(),
        location: _locationController.text.toString(),
        idProprietaire: 1,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IndexPage(),
        ),
      );
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      print(error.toString());
      _showErrorDialog(error.toString());
    }
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Semantics(
        label: 'image_picker_example_picked_images',
        child: ListView.builder(
          key: UniqueKey(),
          itemBuilder: (BuildContext context, int index) {
            return Semantics(
              label: 'image_picker_example_picked_image',
              child: kIsWeb
                  ? Image.network(_imageFileList![index].path)
                  : Image.file(File(_imageFileList![index].path)),
            );
          },
          itemCount: _imageFileList!.length,
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/tennis.jpg'),
            fit: BoxFit.fill,
          ),
        ),
      );
    }
  }

  Widget _handlePreview() {
    if (isVideo) {
      return Container();
    } else {
      return _previewImages();
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        isVideo = false;
        setState(() {
          if (response.files == null) {
            _setImageFileListFromFile(response.file);
          } else {
            _imageFileList = response.files;
          }
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add optional parameters'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: maxWidthController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxWidth if desired'),
                ),
                TextField(
                  controller: maxHeightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxHeight if desired'),
                ),
                TextField(
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Enter quality if desired'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    final double? width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : null;
                    final double? height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : null;
                    final int? quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : null;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  List<String> photos = [];
  fetchImages() async {
    var url = "http://10.0.2.2:5000/field/" + widget.id.toString();
    var response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    // print(response.body);
    if (response.statusCode == 200) {
      var field = json.decode(response.body);

      var img = field['images'];
      print(img);
      List<String> i = [];
      for (var im in img) {
        i.add(im['name']);
        ;
        print("********");
      }

      setState(() {
        photos = i;
        print(photos);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    // var images = json.decode(widget.images);
    // List<String> photos = [];
    // for (var image in images) {
    //   photos.add(image['name'].toString());
    //   print(image);
    //   print("********");
    // }
    // print(photos);
    // print("****** photos**");

    // var map = images.map((i) => {print(i['name']), photos.add(i['name'])});
    // print(images[0]['name']);
    // print(photos);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Color(0x665ac18e),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => IndexPage()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  _submit();
                },
                child: Icon(
                  Icons.save,
                  color: Colors.black,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x665ac18e),
                  Color(0x995ac18e),
                  Color(0xcc5ac18e),
                  Color(0xff5ac18e),
                ]),
          ),
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height / 3,
                  //   width: double.infinity,
                  //   child: Carousel(
                  //     dotSize: 6.0,
                  //     dotSpacing: 15.0,
                  //     dotPosition: DotPosition.bottomCenter,
                  //     autoplay: false,
                  //     images: [
                  //       Image.asset('assets/images/tennis1.jpg',
                  //           fit: BoxFit.cover),
                  //       Image.asset('assets/images/tennis2.jpeg',
                  //           fit: BoxFit.cover),
                  //       Image.asset('assets/images/tennis3.jpg',
                  //           fit: BoxFit.cover),
                  //     ],
                  //   ),
                  // )

                  // photos.length>2? Container(
                  //   height: 345.0,
                  //   child: CarouselSlider(
                  //     items: photos.map((i) {
                  //       print(i);
                  //       return Builder(
                  //         builder: (BuildContext context) {
                  //           print("********");

                  //           print(i);
                  //           return Container(
                  //               width: MediaQuery.of(context).size.width,
                  //               margin: EdgeInsets.symmetric(horizontal: 5.0),
                  //               decoration: BoxDecoration(color: Colors.amber),
                  //               child: GestureDetector(
                  //                   child: Image.network(
                  //                       "http://10.0.2.2:5000/static/" + i,
                  //                       fit: BoxFit.fill),
                  //                   onTap: () {}));
                  //         },
                  //       );
                  //     }).toList(),
                  //     options: CarouselOptions(height: 400),
                  //   ),
                  // ):
                  photos.length > 0
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: double.infinity,
                          child: Carousel(
                            dotSize: 6.0,
                            dotSpacing: 15.0,
                            dotPosition: DotPosition.bottomCenter,
                            autoplay: false,
                            images: photos.map((i) {
                              print(i);
                              return Builder(
                                builder: (BuildContext context) {
                                  print("******** hedhi l i");

                                  print(i);
                                  return Stack(children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration:
                                          BoxDecoration(color: Colors.amber),
                                      child: Container(
                                        child: GestureDetector(
                                            child: Image.network(
                                                "http://10.0.2.2:5000/static/" +
                                                    i,
                                                fit: BoxFit.fill),
                                            onTap: () {}),
                                      ),
                                    ),
                                    Container(
                                      height: 90,
                                      color: Colors.transparent,
                                      padding: EdgeInsets.only(top: 30),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 24,
                                              right: 24,
                                            ),
                                            child: Row(
                                              children: [
                                                Semantics(
                                                  label:
                                                      'image_picker_example_from_gallery',
                                                  child: MaterialButton(
                                                    onPressed: () {
                                                      isVideo = false;
                                                      _onImageButtonPressed(
                                                        ImageSource.gallery,
                                                      );
                                                    },
                                                    // heroTag: 'image0',
                                                    // tooltip: 'Pick Image from gallery',
                                                    child:
                                                        const Icon(Icons.photo),
                                                  ),
                                                ),
                                                Spacer(),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                  onPressed: () async {
                                                    print(i);
                                                    await Provider.of<Field>(
                                                            context,
                                                            listen: false)
                                                        .deleteImage(
                                                            id: widget.id,
                                                            imageName: i);

                                                    setState(() {
                                                      photos.remove(i);
                                                      fetchImages();
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]);
                                },
                              );
                            }).toList(),
                          ),
                        )
                      : Container(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Name',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        SizedBox(
                          height: 3,
                        ),
                        TextFormField(
                          controller: _nameController,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 9, 77, 9),
                              fontSize: 16),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        // Text('Type', style: TextStyle(color: Colors.black)),
                        // TextFormField(
                        //   controller: _typeController,
                        //   style: const TextStyle(
                        //       color: Color.fromARGB(255, 9, 77, 9), fontSize: 16),
                        //   decoration: InputDecoration(
                        //     fillColor: Colors.white,
                        //     filled: true,
                        //     contentPadding:
                        //         const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        //     enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(color: Colors.grey[400]!),
                        //         borderRadius: BorderRadius.circular(10)),
                        //     border: OutlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.grey[400]!),
                        //     ),
                        //   ),
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Invalid Type';
                        //     }
                        //   },
                        // ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        Text('Address',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        SizedBox(
                          height: 3,
                        ),
                        TextFormField(
                          controller: _addressController,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 9, 77, 9),
                              fontSize: 16),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a value.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Location',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        SizedBox(
                          height: 3,
                        ),
                        TextFormField(
                          controller: _locationController,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 9, 77, 9),
                              fontSize: 16),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a value.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Price',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        SizedBox(
                          height: 3,
                        ),
                        TextFormField(
                          controller: _prixController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 9, 77, 9),
                              fontSize: 16),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                          ),
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
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        Text('Services',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        SizedBox(
                          height: 3,
                        ),
                        TextFormField(
                          controller: _servicesController,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 9, 77, 9),
                              fontSize: 16),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Period',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        SizedBox(
                          height: 3,
                        ),
                        TextFormField(
                          controller: _periodController,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 9, 77, 9),
                              fontSize: 16),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.timer,
                              color: Colors.white,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if (pickedTime != null) {
                              print(
                                  pickedTime.format(context)); //output 10:51 PM
                              DateTime parsedTime = DateFormat.jm()
                                  .parse(pickedTime.format(context).toString());
                              //converting to DateTime so that we can further format on different pattern.
                              print(
                                  parsedTime); //output 1970-01-01 22:53:00.000
                              String formattedTime =
                                  DateFormat('HH:mm:ss').format(parsedTime);
                              print(formattedTime); //output 14:59:00
                              //DateFormat() is from intl package, you can format the time on any pattern you need.

                              setState(() {
                                _periodController.text =
                                    formattedTime; //set the value of text field.
                              });
                            } else {
                              print("Time is not selected");
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Opening',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        SizedBox(
                          height: 3,
                        ),
                        TextFormField(
                          controller: _openingController,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 9, 77, 9),
                              fontSize: 16),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.timer,
                              color: Colors.white,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if (pickedTime != null) {
                              print(
                                  pickedTime.format(context)); //output 10:51 PM
                              DateTime parsedTime = DateFormat.jm()
                                  .parse(pickedTime.format(context).toString());
                              //converting to DateTime so that we can further format on different pattern.
                              print(
                                  parsedTime); //output 1970-01-01 22:53:00.000
                              String formattedTime =
                                  DateFormat('HH:mm:ss').format(parsedTime);
                              print(formattedTime); //output 14:59:00
                              //DateFormat() is from intl package, you can format the time on any pattern you need.

                              setState(() {
                                _openingController.text =
                                    formattedTime; //set the value of text field.
                              });
                            } else {
                              print("Time is not selected");
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Closing',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        SizedBox(
                          height: 3,
                        ),
                        TextFormField(
                          controller: _closingController,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 9, 77, 9),
                              fontSize: 16),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.timer,
                              color: Colors.white,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if (pickedTime != null) {
                              print(
                                  pickedTime.format(context)); //output 10:51 PM
                              DateTime parsedTime = DateFormat.jm()
                                  .parse(pickedTime.format(context).toString());
                              //converting to DateTime so that we can further format on different pattern.
                              print(
                                  parsedTime); //output 1970-01-01 22:53:00.000
                              String formattedTime =
                                  DateFormat('HH:mm:ss').format(parsedTime);
                              print(formattedTime); //output 14:59:00
                              //DateFormat() is from intl package, you can format the time on any pattern you need.

                              setState(() {
                                _closingController.text =
                                    formattedTime; //set the value of text field.
                              });
                            } else {
                              print("Time is not selected");
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Surface',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: DropdownButton(
                            style: const TextStyle(
                                color: Color.fromARGB(255, 9, 77, 9),
                                fontSize: 16),
                            dropdownColor: Colors.white,
                            underline: SizedBox(),
                            isExpanded: true,
                            value: _surfaceController.text,
                            onChanged: (newVal) {
                              setState(() {
                                _surfaceController.text = newVal.toString();
                              });
                            },
                            items: surfaces.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                          ),
                        ),
                        // TextFormField(
                        //   controller: _surfaceController,
                        //   style: const TextStyle(
                        //       color: Color.fromARGB(255, 9, 77, 9), fontSize: 16),
                        //   decoration: InputDecoration(
                        //     fillColor: Colors.white,
                        //     filled: true,
                        //     contentPadding:
                        //         const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        //     enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(color: Colors.grey[400]!),
                        //         borderRadius: BorderRadius.circular(10)),
                        //     border: OutlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.grey[400]!),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Description',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        SizedBox(
                          height: 3,
                        ),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 6,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 9, 77, 9),
                              fontSize: 16),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a description.';
                            }
                            if (value.length < 10) {
                              return 'Should be at least 10 characters long.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          constraints:
                              const BoxConstraints(minWidth: double.infinity),
                          child: TextButton(
                            onPressed: () async {
                              setState(() {
                                _displayAvailibilityFields =
                                    !_displayAvailibilityFields;
                              });
                            },
                            child: const Text(
                              "Change unavailibility",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 63, 62, 62),
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 8.0,
                                      color: Color.fromARGB(255, 121, 119, 119),
                                    ),
                                  ],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Visibility(
                          visible: _displayAvailibilityFields,
                          child: Text(
                            'start date',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Visibility(
                          visible: _displayAvailibilityFields,
                          child: TextFormField(
                            controller: _unavailabilityStartDateController,
                            readOnly: true,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 9, 77, 9),
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]!),
                              ),
                            ),
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Invalid isNotAvailable';
                            //   }
                            // },
                            // onTap: () async {
                            //   DateTime? pickedDate = await showDatePicker(
                            //       context: context,
                            //       initialDate: DateTime.now(),
                            //       firstDate: DateTime(
                            //           2000), //DateTime.now() - not to allow to choose before today.
                            //       lastDate: DateTime(2101));

                            //   if (pickedDate != null) {
                            //     print(
                            //         pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            //     String formattedDate =
                            //         DateFormat('yyyy-MM-dd').format(pickedDate);
                            //     print(
                            //         formattedDate); //formatted date output using intl package =>  2021-03-16
                            //     //you can implement different kind of Date Format here according to your requirement

                            //     setState(() {
                            //       _unavailabilityStartDateController.text =
                            //           formattedDate; //set output date to TextField value.
                            //     });
                            //   } else {
                            //     print("Date is not selected");
                            //   }
                            //},
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                print(pickedDate
                                    .year); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement
                                TimeOfDay? pickedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                );

                                if (pickedTime != null) {
                                  print(pickedTime
                                      .format(context)); //output 10:51 PM
                                  DateTime parsedTime = DateFormat.jm().parse(
                                      pickedTime.format(context).toString());
                                  //converting to DateTime so that we can further format on different pattern.
                                  print(
                                      parsedTime); //output 1970-01-01 22:53:00.000
                                  String formattedTime =
                                      DateFormat('HH:mm:ss').format(parsedTime);
                                  print(formattedTime);
                                }
                                final toUTC = DateTime(
                                    pickedDate.year,
                                    pickedDate.month,
                                    pickedDate.day,
                                    pickedTime!.hour,
                                    pickedTime.minute);
                                print(toUTC);
                                setState(() {
                                  _unavailabilityStartDateController.text = toUTC
                                      .toString(); //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Visibility(
                          visible: _displayAvailibilityFields,
                          child: Text(
                            'finish date',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Visibility(
                          visible: _displayAvailibilityFields,
                          child: TextFormField(
                            controller: _unavailabilityFinishDateController,
                            readOnly: true,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 9, 77, 9),
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]!),
                              ),
                            ),
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Invalid isNotAvailable';
                            //   }
                            // },
                            // onTap: () async {
                            //   DateTime? pickedDate = await showDatePicker(
                            //       context: context,
                            //       initialDate: DateTime.now(),
                            //       firstDate: DateTime
                            //           .now(), //DateTime.now() - not to allow to choose before today.
                            //       lastDate: DateTime(2101));

                            //   if (pickedDate != null) {
                            //     print(
                            //         pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            //     String formattedDate =
                            //         DateFormat('yyyy-MM-dd').format(pickedDate);
                            //     print(
                            //         formattedDate); //formatted date output using intl package =>  2021-03-16
                            //     //you can implement different kind of Date Format here according to your requirement

                            //     setState(() {
                            //       _unavailabilityFinishDateController.text =
                            //           formattedDate; //set output date to TextField value.
                            //     });
                            //   } else {
                            //     print("Date is not selected");
                            //   }
                            // },
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                print(pickedDate
                                    .year); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement
                                TimeOfDay? pickedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                );

                                if (pickedTime != null) {
                                  print(pickedTime
                                      .format(context)); //output 10:51 PM
                                  DateTime parsedTime = DateFormat.jm().parse(
                                      pickedTime.format(context).toString());
                                  //converting to DateTime so that we can further format on different pattern.
                                  print(
                                      parsedTime); //output 1970-01-01 22:53:00.000
                                  String formattedTime =
                                      DateFormat('HH:mm:ss').format(parsedTime);
                                  print(formattedTime);
                                }
                                final toUTC = DateTime(
                                    pickedDate.year,
                                    pickedDate.month,
                                    pickedDate.day,
                                    pickedTime!.hour,
                                    pickedTime.minute);
                                print(toUTC);
                                setState(() {
                                  _unavailabilityFinishDateController.text = toUTC
                                      .toString(); //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        // Text('startDate', style: TextStyle(color: Colors.black)),
                        // TextFormField(
                        //   controller: _unavailabilityStartDateController,
                        //   style: const TextStyle(
                        //       color: Color.fromARGB(255, 9, 77, 9), fontSize: 16),
                        //   decoration: InputDecoration(
                        //     fillColor: Colors.white,
                        //     filled: true,
                        //     contentPadding:
                        //         const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        //     enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(color: Colors.grey[400]!),
                        //         borderRadius: BorderRadius.circular(10)),
                        //     border: OutlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.grey[400]!),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        // Text('finish date', style: TextStyle(color: Colors.black)),
                        // TextFormField(
                        //   controller: _unavailabilityFinishDateController,
                        //   style: const TextStyle(
                        //       color: Color.fromARGB(255, 9, 77, 9), fontSize: 16),
                        //   decoration: InputDecoration(
                        //     fillColor: Colors.white,
                        //     filled: true,
                        //     contentPadding:
                        //         const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        //     enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(color: Colors.grey[400]!),
                        //         borderRadius: BorderRadius.circular(10)),
                        //     border: OutlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.grey[400]!),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 30,
                        // ),

                        Center(
                          child: Container(
                            width: 250,
                            padding: const EdgeInsets.only(top: 3, left: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: _submit,
                              color: const Color.fromARGB(255, 13, 117, 16),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    "UPDATE",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Icon(
                                    Icons.save,
                                    color: Colors.white,
                                    size: 26.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
