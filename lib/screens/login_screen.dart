import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class LoginScreen extends StatelessWidget {
  static const routName = '/login';

  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 177, 212, 165),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              'TAKWIRA2',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
            Image.asset("assets/images/takwiraLogo.jpg"),
            LoginCard(),
            ElevatedButton(
                onPressed: () => {}, child: Text('already have an account ?')),
          ],
        ),
      ),
    );
  }
}

class LoginCard extends StatefulWidget {
  @override
  _LoginCardState createState() => _LoginCardState();
}

final GlobalKey<FormState> _formKey = GlobalKey();

class _LoginCardState extends State<LoginCard> {
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
