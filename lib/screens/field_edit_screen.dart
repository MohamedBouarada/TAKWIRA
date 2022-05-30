// ignore_for_file: import_of_legacy_library_into_null_safe, use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, avoid_print, unused_field

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  }) : super(key: key);

  @override
  _EditCardState createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
  List surfaces = [];
  final Map<String, dynamic> _dates = {"startDate": "", "finishDate": ""};
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
    getFieldInformation();
    handleShowSurfaces();
    print(widget.unavailabilityStartDate);
    _dates['startDate'] = _unavailabilityStartDateController.text.toString();
    _dates['finishDate'] = _unavailabilityFinishDateController.text.toString();
  }

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: double.infinity,
                    child: Carousel(
                      dotSize: 6.0,
                      dotSpacing: 15.0,
                      dotPosition: DotPosition.bottomCenter,
                      autoplay: false,
                      images: [
                        Image.asset('assets/images/tennis1.jpg',
                            fit: BoxFit.cover),
                        Image.asset('assets/images/tennis2.jpeg',
                            fit: BoxFit.cover),
                        Image.asset('assets/images/tennis3.jpg',
                            fit: BoxFit.cover),
                      ],
                    ),
                  )
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
