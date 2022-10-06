// ignore_for_file: unused_import, prefer_const_constructors
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takwira_mobile/providers/field.dart';
import 'package:takwira_mobile/providers/fields.dart';
import 'package:takwira_mobile/screens/bookings_screen.dart';
import 'package:takwira_mobile/screens/client_field_screen.dart';
import 'package:takwira_mobile/screens/field_details_screen.dart';
import 'package:takwira_mobile/screens/owner_booking_screen.dart';
import 'package:takwira_mobile/screens/root_app.dart';
import 'package:takwira_mobile/screens/setting.dart';
import 'package:takwira_mobile/screens/signup.dart';
import 'package:takwira_mobile/widgets/booking.dart';
import 'package:takwira_mobile/widgets/helpContainer.dart';
import './providers/auth.dart';
//import './providers/fields.dart';
import './providers/field/fields.dart';
import './providers/field/field.dart';
import './screens//fields_screen.dart';
import './screens/home_page.dart';
import './screens//login.dart';
import 'pages/field_edit.dart';
import 'pages/field_list.dart';
import 'screens/field_edit_screen.dart';

import 'screens/owner_field_list.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  print(dotenv.env['addressIp']);
  runApp(const MyApp());
}

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
          value: FieldsProvider(),
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
          //home: Details( imgUrl: 'http://images.pexels.com/photos/1659438/pexels-photo-1659438.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260', placeName: 'hammamet', rating: 4.5,),
          //home: HelpContainer(),
          //home: ClientFieldScreen(),
          //home: RootApp(),
          //home: Booking(),
          home: HomePage(),
          //home: IndexPage(),
          routes: {
            LoginPage.routName: (ctx) => LoginPage(),
            SignupPage.routName: (ctx) => SignupPage(),
            ClientFieldScreen.routeName: (context) => ClientFieldScreen(),
            Details.routeName: (context) => Details(),
            EditFieldList.routeName: (context) => EditFieldList(),
            FieldsList.routeName: (ctx) => FieldsList(),
            HomePage.routeName: (ctx) => HomePage(),
            RootApp.routeName: (ctx) => RootApp(),
            IndexPage.routName: (context) => IndexPage(),
            BookingsScreen.routeName: (context) => BookingsScreen(),
            OwnerBookingScreen.routeName: (context) => OwnerBookingScreen(),

            // '/edit-Field': (context) => const FieldAdd(),
          },
        ),
      ),
    );
  }
}
