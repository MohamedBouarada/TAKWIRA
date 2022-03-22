import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './screens/register_screen.dart';
import './screens//fields_screen.dart';
import './screens/login_screen.dart';

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
          home: auth.isAuth ? const FieldsScreen() : const LoginScreen(),
          routes: {
            //LoginScreen.routName: (ctx) => LoginScreen(),
            AuthScreen.routName: (ctx) => AuthScreen(),
          },
        ),
      ),
    );
  }
}
