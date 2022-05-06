// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:takwira_mobile/providers/storage_service.dart';
import 'package:takwira_mobile/screens/fields_screen.dart';
import '../animation/FadeAnimation.dart';
import '../screens/login.dart';
import '../screens/signup.dart';

class HomePage extends StatefulWidget {
  static bool isAuth = false;
  const HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final StorageService _storageService = StorageService();
  String _token = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readToken();
  }

  void readToken() async {
    _token = (await _storageService.readSecureData('token'))!;
    setState(() {});
    HomePage.isAuth = _token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return HomePage.isAuth
        ? FieldsScreen()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: SingleChildScrollView(
                child: Container(
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
                      ],
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          FadeAnimation(
                            1,
                            Text("TAKWIRA",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                  color: Color.fromARGB(255, 13, 117, 16),
                                )),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          FadeAnimation(
                            1.2,
                            Text(
                              "welcome to takwira where you can reserve any sports field ala kifek",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      FadeAnimation(
                        1.4,
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/logo0.png'),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          FadeAnimation(
                            1.5,
                            MaterialButton(
                              minWidth: double.infinity,
                              height: 55,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              color: Color.fromARGB(255, 13, 117, 16),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                            1.6,
                            Container(
                              padding: EdgeInsets.only(top: 3, left: 3),
                              child: MaterialButton(
                                minWidth: double.infinity,
                                height: 55,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignupPage(),
                                    ),
                                  );
                                },
                                color: Colors.white,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  side:
                                      BorderSide(width: 2, color: Colors.green),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 13, 117, 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
