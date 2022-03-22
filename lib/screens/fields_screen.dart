import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class FieldsScreen extends StatelessWidget {
  static const routName = '/fields';

  const FieldsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 177, 212, 165),
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}
