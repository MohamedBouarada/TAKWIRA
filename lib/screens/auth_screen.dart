import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Flexible(child: AuthCard()),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _passwordController = TextEditingController();
  Future<void> _submit() async {}

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      child: Container(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid Email';
                    }
                  },
                  onSaved: (newValue) {
                    _authData['email'] = newValue!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is invalid';
                    }
                  },
                  onSaved: (newValue) {
                    _authData['password'] = newValue!;
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: ' repeat Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords does not match';
                    }
                  },
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
