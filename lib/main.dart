// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takwira_mobile/providers/field.dart';
import 'package:takwira_mobile/providers/fields.dart';
import 'package:takwira_mobile/screens/client_field_screen.dart';
import 'package:takwira_mobile/screens/signup.dart';
import './providers/auth.dart';
import './providers/fields.dart';
import './screens//fields_screen.dart';
import './screens/home_page.dart';
import './screens//login.dart';
import 'screens/field_edit_screen.dart';
import 'pages/field_list.dart';
import 'pages/field_edit.dart';
import 'screens/owner_field_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Field(),
        ),
        ChangeNotifierProvider.value(
          value: Fields(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Takwira',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: ClientFieldScreen(),
          routes: {
            LoginPage.routName: (ctx) => LoginPage(),
            SignupPage.routName: (ctx) => SignupPage(),
            EditFieldList.routeName: (context) => EditFieldList(),
            FieldsList.routeName:(ctx)=>FieldsList(),
            IndexPage.routName: (context) => IndexPage(),
            // '/edit-Field': (context) => const FieldAdd(),
          },
        ),
      ),
    );
  }
}
