import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 177, 212, 165),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    width: 3,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.green,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/takwiraLogo.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const Text(
                'TAKWIRA',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
              AuthCard(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, "/login"),
                child: const Text('already have an account ?'),
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

final GlobalKey<FormState> _formKey = GlobalKey();

class _AuthCardState extends State<AuthCard> {
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'firstName': '',
    'lastName': '',
    'phoneNumber': '',
  };

  Future<void> _submit() async {}

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      child: Container(
        color: Color.fromARGB(255, 177, 212, 165),
        width: deviceSize.width * 0.9,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'E-mail',
                      fillColor: Colors.white,
                      filled: true),
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid Email';
                    }
                  },
                  onSaved: (newValue) {
                    _authData['email'] = newValue!;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'First Name',
                              fillColor: Colors.white,
                              filled: true),
                          keyboardType: TextInputType.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Invalid first name';
                            }
                          },
                          onSaved: (newValue) {
                            _authData['firstName'] = newValue!;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Last Name',
                            fillColor: Colors.white,
                            filled: true),
                        keyboardType: TextInputType.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Invalid first name';
                          }
                        },
                        onSaved: (newValue) {
                          _authData['lastName'] = newValue!;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      fillColor: Colors.white,
                      filled: true),
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      fillColor: Colors.white,
                      filled: true),
                  obscureText: true,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is invalid';
                    }
                  },
                  onSaved: (newValue) {
                    _authData['password'] = newValue!;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
