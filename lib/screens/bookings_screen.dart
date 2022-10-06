// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:takwira_mobile/screens/root_app.dart';

import '../providers/field/fields.dart';
import '../themes/color.dart';

// const IconData sports_tennis = IconData(0xe5f3, fontFamily: 'MaterialIcons');
// const IconData sports = IconData(0xe5e3, fontFamily: 'MaterialIcons');
// const IconData sports_football_outlined =
//     IconData(0x5e6, fontFamily: 'MaterialIcons');

class BookingsScreen extends StatefulWidget {
  BookingsScreen({Key? key}) : super(key: key);
  static const routeName = '/client-bookings-screen';

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  List bookings = [];

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
        .getClientBookings();

    setState(() {
      bookings = bookingList;
      print(bookings.runtimeType);
      print(bookings.length);
    });
  }

  @override
  void initState() {
    super.initState();

    getBookings();
  }

  void showAlertDialog(int index) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: Container(
                child: Column(
                  children: [
                    DefaultTextStyle(
                      style: GoogleFonts.nunito(
                        color: actionColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      child: Text('Reservation cancellation'),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: DefaultTextStyle(
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          child: Text(
                            "are you sure you want to cancel this reservation?",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: DefaultTextStyle(
                            style: TextStyle(color: Colors.black),
                            child: Text('Cancel'),
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () async {
                            await Provider.of<FieldsProvider>(context,
                                    listen: false)
                                .cancelBookingClient(index);
                            setState(() {
                              getBookings();
                            });
                            Navigator.of(context).pop();
                          },
                          child: DefaultTextStyle(
                            style: TextStyle(color: actionColor),
                            child: Text('confirm'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(color: actionColor, spreadRadius: 2),
                  ],
                ),
                width: MediaQuery.of(context).size.width * (4 / 5),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 80,
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
                                bookings[index]['address'].toString(),
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
                                Icons.place,
                                color: d_green,
                                size: 14.0,
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
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                bookings[index]['date']
                                    .split(' ')
                                    .last
                                    .toString(),
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
                                size: 14.0,
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
                          Container(
                            padding: EdgeInsets.only(top: 1, left: 1),
                            child: MaterialButton(
                              minWidth: 100,
                              height: 30,
                              onPressed: () {
                                //print(bookings[index]['reservationId']);
                                showAlertDialog(
                                    bookings[index]['reservationId']);
                              },
                              color: Colors.white,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 2, color: actionColor),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                "cancel",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: actionColor,
                                ),
                              ),
                            ),
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
            SizedBox(height: 100,),
          ],
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
          Navigator.of(context).pushNamed(RootApp.routeName);
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
