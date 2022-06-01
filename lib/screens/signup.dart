// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, deprecated_member_use, missing_return, prefer_final_fields

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takwira_mobile/animation/FadeAnimation.dart';
import 'package:takwira_mobile/models/http_exception.dart';
import 'package:takwira_mobile/providers/auth.dart';
import 'package:takwira_mobile/screens/home_page.dart';
import 'package:takwira_mobile/screens/login.dart';

class SignupPage extends StatelessWidget {
  static const routName = '/signup';
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
                context, MaterialPageRoute(builder: (context) => HomePage()));
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
          height: MediaQuery.of(context).size.height,
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
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/mainLogo.png'),
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
                      "Sign up",
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
              AuthCard(),
              SizedBox(
                height: 15,
              ),
              FadeAnimation(
                1.6,
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/login"),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        " Login",
                        style: TextStyle(shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 8.0,
                            color: Color.fromARGB(255, 121, 119, 119),
                          ),
                        ], fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ],
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

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState>? _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'repeatPassword':'',
    'firstName': '',
    'lastName': '',
    'phoneNumber': '',
    'role':'CLIENT',
  };
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

    try {
      await Provider.of<Auth>(context, listen: false).signup(
        email: _authData['email']!,
        firstName: _authData['firstName']!,
        lastName: _authData['lastName']!,
        phoneNumber: _authData['phoneNumber']!,
        password: _authData['password']!,
        repeatPassword: _authData['repeatPassword']!,
        role: _authData['role']!,
        
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog("oops! something went wrong , please try again");
    }
  }

  final roles = [
    {'display': "owner", 'value': "OWNER_REQUEST"},
    {'display': "client", 'value': "CLIENT"},
    
  ];

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
                    labelText: 'E-mail',
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
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid Email';
                    }
                  },
                  onSaved: (newValue) {
                    _authData['email'] = newValue!;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              FadeAnimation(
                1.5,
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: TextFormField(
                          style: const TextStyle(
                              color: Color.fromARGB(255, 9, 77, 9),
                              fontSize: 16),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'First Name',
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
                              return 'Invalid first name';
                            }
                          },
                          onSaved: (newValue) {
                            _authData['firstName'] = newValue!;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 9, 77, 9), fontSize: 16),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Last Name',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
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
                            return 'Invalid Last Name';
                          }
                        },
                        onSaved: (newValue) {
                          _authData['lastName'] = newValue!;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              FadeAnimation(
                1.6,
                TextFormField(
                  style: const TextStyle(
                    color: Color.fromARGB(255, 9, 77, 9),
                    fontSize: 16,
                  ),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Phone Number',
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
                    var regExp = RegExp('[0-9]{8}');
                    if (value!.isEmpty ||
                        !regExp.hasMatch(value) ||
                        value.length != 8) {
                      return 'Invalid phone number';
                    }
                  },
                  onSaved: (newValue) {
                    _authData['phoneNumber'] = newValue!;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1.4,
                TextFormField(
                  style: const TextStyle(
                      color: Color.fromARGB(255, 9, 77, 9), fontSize: 16),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Password',
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
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is invalid';
                    }
                  },
                  onSaved: (newValue) {
                    _authData['password'] = newValue!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1.5,
                TextFormField(
                  style: const TextStyle(
                      color: Color.fromARGB(255, 9, 77, 9), fontSize: 16),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Repeat password',
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
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is incorrect';
                    }
                  },
                  onSaved: (newValue) {
                    _authData['repeatPassword'] = newValue!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1.6,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: null,
                    color: Colors.white,
                  ),
                  child: DropDownFormField(
                    filled: true,
                    titleText: 'role',
                    hintText: 'Please choose one',
                    value: _authData['role'],
                    onSaved: (value) {
                      setState(() {
                        _authData['role'] = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _authData['role'] = value;
                      });
                    },
                    dataSource: roles,
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FadeAnimation(
                1.7,
                Container(
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
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
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
