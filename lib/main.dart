import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takwira_mobile/screens/signup.dart';
import './providers/auth.dart';
import './screens/register_screen.dart';
import './screens//fields_screen.dart';
import './screens/home_page.dart';
import './screens//login.dart';

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
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Takwira',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: HomePage(),
          routes: {
            LoginPage.routName: (ctx) => LoginPage(),
            SignupPage.routName: (ctx) => SignupPage(),
          },
        ),
      ),
    );
  }
}
