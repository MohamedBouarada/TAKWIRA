// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, deprecated_member_use, missing_return, prefer_final_fields, avoid_print, import_of_legacy_library_into_null_safe, unused_import

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:provider/provider.dart';
import 'package:takwira_mobile/animation/FadeAnimation.dart';
import 'package:takwira_mobile/models/http_exception.dart';
import 'package:takwira_mobile/providers/field.dart';

import 'package:takwira_mobile/screens/login.dart';
import 'package:takwira_mobile/screens/owner_field_list.dart';

class FieldAdd extends StatelessWidget {
  static const routName = '/field-add';
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
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
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
              ])),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/tennis.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    1,
                    Text(
                      "Add New Field",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  // FadeAnimation(
                  //     1.2,
                  //     Text(
                  //       "Create an account, It's free",
                  //       style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  //     )),
                  // SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
              FieldCard(),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FieldCard extends StatefulWidget {
  @override
  _FieldCardState createState() => _FieldCardState();
}

class _FieldCardState extends State<FieldCard> {
  List<Map<String, String>> surfaces = [];
  final List<Map<String, String>> fieldTypes = [];

  final Map<String, dynamic> _dates = {"startDate": "", "finishDate": ""};
  // Map<String, String> dates = {"startDate": "aa", "finishDate": "bb"};
  bool _displayNewTextField = false;
  TextEditingController timeinput = TextEditingController();
  TextEditingController openingController = TextEditingController();
  TextEditingController closingController = TextEditingController();
  TextEditingController dateinputStart = TextEditingController();
  TextEditingController dateinputFinish = TextEditingController();
  final GlobalKey<FormState>? _formKey = GlobalKey();
  Map<String, dynamic> _authData = {
    'name': '',
    'adresse': '',
    'type': '',
    'isNotAvailable': null,
    'services': '',
    'price': 0.0,
    'period': '',
    'opening': '',
    'closing': '',
    'surface': '',
    'location':'',
    'description': 'filed description',
    'idProprietaire': 1,
  };
  @override
  void initState() {
    timeinput.text = "";
    openingController.text = "";
    closingController.text = "";
    dateinputStart.text = "";
    dateinputFinish.text = "";
    print(_dates);
    //set the initial value of text field
    super.initState();
  }

  void handleShowSurfaces(value) {
    if (value == "TENNIS") {
      setState(() {
        surfaces =
            Provider.of<Field>(context, listen: false).tennisSurfaceTypes;
      });
    } else if (value == "FOOTBALL") {
      setState(() {
        surfaces = Provider.of<Field>(context, listen: false).footSurfaceTypes;
      });
    } else {
      setState(() {
        surfaces = [];
      });
    }
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
    var f = _formKey!.currentState;
    if (f != null && !f.validate()) {
      return;
    }
    _formKey!.currentState!.save();
    print(_dates);
    try {
      await Provider.of<Field>(context, listen: false).add(
        name: _authData['name']!,
        adresse: _authData['adresse']!,
        type: _authData['type']!,
        isNotAvailable: _dates,
        services: _authData['services']!,
        price: double.parse(_authData['price']!),
        period: _authData['period']!,
        opening: _authData['opening']!,
        closing: _authData['closing']!,
        surface: _authData['surface']!,
        location: _authData['location']!,
        description: _authData['description']!,
        idProprietaire: _authData['idProprietaire']!,
      );
      print(_authData);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IndexPage(),
        ),
      );
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FadeAnimation(
                1.3,
                TextFormField(
                  style: const TextStyle(
                    color: Color.fromARGB(255, 9, 77, 9),
                    fontSize: 16,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Name',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Invalid Name';
                    }
                  },
                  onSaved: (newValue) {
                    _authData['name'] = newValue!;
                    // if (newValue == "TENNIS") {
                    //   setState(() {
                    //     surfaces = Provider.of<Field>(context, listen: false)
                    //         .tennisSurfaceTypes;
                    //   });
                    // } else if (newValue == "FOOTBALL") {
                    //   setState(() {
                    //     surfaces = Provider.of<Field>(context, listen: false)
                    //         .footSurfaceTypes;
                    //   });
                    // }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              FadeAnimation(
                1.4,
                TextFormField(
                  style: const TextStyle(
                      color: Color.fromARGB(255, 9, 77, 9), fontSize: 16),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Type',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Invalid type';
                    }
                  },
                  onChanged: (newValue) {
                    setState(() {
                      handleShowSurfaces(newValue);
                    });
                  },
                  onSaved: (newValue) {
                    _authData['type'] = newValue!;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              FadeAnimation(
                1.5,
                TextFormField(
                  style: const TextStyle(
                      color: Color.fromARGB(255, 9, 77, 9), fontSize: 16),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'adresse',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Invalid Address';
                    }
                  },
                  onSaved: (newValue) {
                    _authData['adresse'] = newValue!;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              FadeAnimation(
                1.3,
                TextFormField(
                  style: const TextStyle(
                    color: Color.fromARGB(255, 9, 77, 9),
                    fontSize: 16,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Location',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Location';
                    }
                  },
                  onSaved: (newValue) {
                    _authData['location'] = newValue!;
                    // if (newValue == "TENNIS") {
                    //   setState(() {
                    //     surfaces = Provider.of<Field>(context, listen: false)
                    //         .tennisSurfaceTypes;
                    //   });
                    // } else if (newValue == "FOOTBALL") {
                    //   setState(() {
                    //     surfaces = Provider.of<Field>(context, listen: false)
                    //         .footSurfaceTypes;
                    //   });
                    // }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),

              FadeAnimation(
                1.6,
                TextFormField(
                  style: const TextStyle(
                      color: Color.fromARGB(255, 9, 77, 9), fontSize: 16),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'services',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'services is invalid';
                  //   }
                  // },
                  onSaved: (newValue) {
                    _authData['services'] = newValue!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1.7,
                TextFormField(
                  style: const TextStyle(
                      color: Color.fromARGB(255, 9, 77, 9), fontSize: 16),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'price',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'price is invalid';
                  //   }
                  // },
                  onSaved: (newValue) {
                    _authData['price'] = newValue!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1.8,
                TextFormField(
                  controller: timeinput,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 9, 77, 9), fontSize: 16),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.timer,
                      color: Colors.white,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'period',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ),
                  readOnly: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'period is invalid';
                  //   }
                  // },
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );

                    if (pickedTime != null) {
                      print(pickedTime.format(context)); //output 10:51 PM
                      DateTime parsedTime = DateFormat.jm()
                          .parse(pickedTime.format(context).toString());
                      //converting to DateTime so that we can further format on different pattern.
                      print(parsedTime); //output 1970-01-01 22:53:00.000
                      String formattedTime =
                          DateFormat('HH:mm:ss').format(parsedTime);
                      print(formattedTime); //output 14:59:00
                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                        timeinput.text =
                            formattedTime; //set the value of text field.
                      });
                    } else {
                      print("Time is not selected");
                    }
                  },
                  onSaved: (newValue) {
                    _authData['period'] = newValue!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1.84,
                TextFormField(
                  controller: openingController,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 9, 77, 9), fontSize: 16),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.timer,
                      color: Colors.white,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'opening',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ),
                  readOnly: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'period is invalid';
                  //   }
                  // },
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );

                    if (pickedTime != null) {
                      print(pickedTime.format(context)); //output 10:51 PM
                      DateTime parsedTime = DateFormat.jm()
                          .parse(pickedTime.format(context).toString());
                      //converting to DateTime so that we can further format on different pattern.
                      print(parsedTime); //output 1970-01-01 22:53:00.000
                      String formattedTime =
                          DateFormat('HH:mm:ss').format(parsedTime);
                      print(formattedTime); //output 14:59:00
                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                        openingController.text =
                            formattedTime; //set the value of text field.
                      });
                    } else {
                      print("Time is not selected");
                    }
                  },
                  onSaved: (newValue) {
                    _authData['opening'] = newValue!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1.8,
                TextFormField(
                  controller: closingController,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 9, 77, 9), fontSize: 16),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.timer,
                      color: Colors.white,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'period',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ),
                  readOnly: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'period is invalid';
                  //   }
                  // },
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );

                    if (pickedTime != null) {
                      print(pickedTime.format(context)); //output 10:51 PM
                      DateTime parsedTime = DateFormat.jm()
                          .parse(pickedTime.format(context).toString());
                      //converting to DateTime so that we can further format on different pattern.
                      print(parsedTime); //output 1970-01-01 22:53:00.000
                      String formattedTime =
                          DateFormat('HH:mm:ss').format(parsedTime);
                      print(formattedTime); //output 14:59:00
                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                        closingController.text =
                            formattedTime; //set the value of text field.
                      });
                    } else {
                      print("Time is not selected");
                    }
                  },
                  onSaved: (newValue) {
                    _authData['closing'] = newValue!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // FadeAnimation(
              //   2,
              //   TextFormField(
              //     style: const TextStyle(
              //         color: Color.fromARGB(255, 9, 77, 9), fontSize: 16),

              //     decoration: InputDecoration(
              //       fillColor: Colors.white,
              //       filled: true,
              //       labelText: 'surface',
              //       contentPadding: const EdgeInsets.symmetric(
              //         vertical: 0,
              //         horizontal: 10,
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.grey[400]!),
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       border: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: Colors.grey[400]!,
              //         ),
              //       ),
              //     ),
              //     autovalidateMode: AutovalidateMode.onUserInteraction,
              //     // validator: (value) {
              //     //   if (value!.isEmpty) {
              //     //     return 'surface is invalid';
              //     //   }
              //     // },
              //     onSaved: (newValue) {
              //       _authData['surface'] = newValue!;
              //     },
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              FadeAnimation(
                  1.9,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: null,
                      color: Colors.white,
                    ),
                    child: DropDownFormField(
                      filled: true,
                      titleText: 'Surface',
                      hintText: 'Please choose one',
                      value: _authData['surface'],
                      onSaved: (value) {
                        setState(() {
                          _authData['surface'] = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          _authData['surface'] = value;
                        });
                      },
                      dataSource: surfaces,
                      textField: 'display',
                      valueField: 'value',
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                2,
                TextFormField(
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 9, 77, 9), fontSize: 16),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'description',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'description is invalid';
                  //   }
                  // },
                  onSaved: (newValue) {
                    _authData['description'] = newValue!;
                  },
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Container(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: TextButton(
                  onPressed: () async {
                    setState(() {
                      _displayNewTextField = !_displayNewTextField;
                    });
                  },
                  child: const Text(
                    "you can choose when your field is not available",
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
              Visibility(
                visible: _displayNewTextField,
                child: TextFormField(
                  controller: dateinputStart,
                  readOnly: true,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 9, 77, 9),
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today, color: Colors.white),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'start date',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
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
                  //       dateinputStart.text =
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
                        print(pickedTime.format(context)); //output 10:51 PM
                        DateTime parsedTime = DateFormat.jm()
                            .parse(pickedTime.format(context).toString());
                        //converting to DateTime so that we can further format on different pattern.
                        print(parsedTime); //output 1970-01-01 22:53:00.000
                        String formattedTime =
                            DateFormat('HH:mm:ss').format(parsedTime);
                        print(formattedTime);
                      }
                      final toUTC = DateTime(pickedDate.year, pickedDate.month,
                          pickedDate.day, pickedTime!.hour, pickedTime.minute);
                      print(toUTC);
                      setState(() {
                        dateinputStart.text = toUTC
                            .toString(); //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                  onSaved: (newValue) {
                    print(newValue.toString());
                    _dates['startDate'] = newValue.toString();
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Visibility(
                visible: _displayNewTextField,
                child: SizedBox(
                  height: 20,
                ),
              ),
              Visibility(
                visible: _displayNewTextField,
                child: TextFormField(
                  controller: dateinputFinish,
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
                    labelText: 'finish date',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
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
                  //       dateinputFinish.text =
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
                        print(pickedTime.format(context)); //output 10:51 PM
                        DateTime parsedTime = DateFormat.jm()
                            .parse(pickedTime.format(context).toString());
                        //converting to DateTime so that we can further format on different pattern.
                        print(parsedTime); //output 1970-01-01 22:53:00.000
                        String formattedTime =
                            DateFormat('HH:mm:ss').format(parsedTime);
                        print(formattedTime);
                      }
                      final toUTC = DateTime(pickedDate.year, pickedDate.month,
                          pickedDate.day, pickedTime!.hour, pickedTime.minute);
                      print(toUTC);
                      setState(() {
                        dateinputFinish.text = toUTC
                            .toString(); //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                  onSaved: (newValue) {
                    _dates['finishDate'] = newValue.toString();
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),

              SizedBox(
                height: 30,
              ),
              FadeAnimation(
                2.2,
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
                            "ADD",
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
                            Icons.add,
                            color: Colors.white,
                            size: 26.0,
                          ),
                        ],
                      ),
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