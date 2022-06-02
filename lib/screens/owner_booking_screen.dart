// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:takwira_mobile/screens/owner_field_list.dart';
import 'package:takwira_mobile/screens/root_app.dart';

import '../providers/field/fields.dart';
import '../themes/color.dart';

// const IconData sports_tennis = IconData(0xe5f3, fontFamily: 'MaterialIcons');
// const IconData sports = IconData(0xe5e3, fontFamily: 'MaterialIcons');
// const IconData sports_football_outlined =
//     IconData(0x5e6, fontFamily: 'MaterialIcons');

class OwnerBookingScreen extends StatefulWidget {
  OwnerBookingScreen({Key? key}) : super(key: key);
  static const routeName = '/owner-bookings-screen';

  @override
  State<OwnerBookingScreen> createState() => _OwnerBookingScreenState();
}

class _OwnerBookingScreenState extends State<OwnerBookingScreen> {
  List bookings = [];
  DateTime currentDateTime = DateTime.now();
  DateTime bookingDateTime = DateTime.now();

  final List list = [
    {
      'field': 'juve',
      'address': 'hammamet',
      'date': "2021_05-02 17:00:00",
    },
    {
      'field': 'bo3',
      'address': 'haaaammamet',
      'date': "2022_05-21 10:00:00",
    },
    {
      'field': 'r3ad',
      'address': 'hammamet',
      'date': "2022_05-04 17:00:00",
    },
    {
      'field': 'scrum',
      'address': 'tunis',
      'date': "2022_05-04 16:30:00",
    }
  ];
  void getBookings() async {
    var bookingList = await Provider.of<FieldsProvider>(context, listen: false)
        .getOwnerBookings();

    setState(() {
      bookings = bookingList;
      print(bookings.runtimeType);
      print(bookings);
    });
  }

  @override
  void initState() {
    super.initState();

    getBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          //child: Text(currentDateTime.toString()),
          child: ListView.builder(
            itemCount: bookings.length,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () async {},
                child: Container(
                  margin: EdgeInsets.all(15),

                  width: MediaQuery.of(context).size.width * 2 / 3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          spreadRadius: 4,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ]),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(children: [
                      Row(
                        children: [
                          
                            Text(
                              bookings[index]['name'].toString(),
                              style: GoogleFonts.nunito(
                                color: Color.fromARGB(255, 64, 165, 152),
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                            Spacer(),
                            Text(
                              bookings[index]['date']
                                  .split(' ')
                                  .first
                                  .toString(),
                              style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                         

                          //     Icon(
                          //   Icons.ball,
                          //   color: d_green,
                          //   size: 14.0,
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                     
                      Row(
                        children: [
                           Text(
                        bookings[index]['clientName'].toString(),
                        style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      Icon(
                            Icons.phone,
                            color: d_green,
                            size: 15.0,
                          ),
                           SizedBox(
                            width: 6,
                          ),
                          Text(
                            bookings[index]['clientNumber'].toString(),
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                         
                          
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            bookings[index]['date'].split(' ').last.toString(),
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: d_green,
                            size: 15.0,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            bookings[index]['finishDate']
                                .split(' ')
                                .last
                                .toString(),
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  //   child: Text(
                  //     list[index]['field'].toString(),
                  //     style: GoogleFonts.nunito(
                  //       color: Color.fromARGB(255, 64, 165, 152),
                  //       fontWeight: FontWeight.w800,
                  //       fontSize: 23,
                  //     ),

                  // ),
                ),
              );
              //Text(dates[index].toString());
            },
          ),
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.grey[800],
          size: 25,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(IndexPage.routName);
        },
      ),
      title: Text(
        'Bookings',
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      // actions: [

      // ],
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}
