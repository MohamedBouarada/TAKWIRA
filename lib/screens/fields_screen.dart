import 'package:flutter/material.dart';
import 'package:takwira_mobile/models/storage_item.dart';
import 'package:takwira_mobile/providers/storage_service.dart';
import 'package:takwira_mobile/screens/home_page.dart';

enum AuthMode { Signup, Login }

class FieldsScreen extends StatelessWidget {
  static const routName = '/fields';

  const FieldsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 177, 212, 165),
      body: Column(children: <Widget>[
        Text("Hello"),
        ElevatedButton(
          onPressed: () {
            final StorageService storageService = StorageService();
            final StorageItem item = StorageItem('token', "");
            storageService.writeSecureData(item);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          child: Text("logout"),
        ),
      ]),
    );
  }
}
