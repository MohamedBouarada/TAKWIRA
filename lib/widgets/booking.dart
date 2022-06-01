// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, avoid_print
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/field/fields.dart';
import '../utils/date_utils.dart' as date_util;
import '../utils/colors_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import '../themes/color.dart';

const d_green = Color(0xFF54D3C2);

class Booking extends StatefulWidget {
  final int fieldId;
  const Booking({Key? key, required this.fieldId}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  double width = 0.0;
  double height = 0.0;
  int id = -1;
  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  DateTime currentDayOfMonth = DateTime.now();
  List<String> todos = <String>[];
  TextEditingController controller = TextEditingController();
  var dates;
  String bookingDate = '';
  @override
  void initState() {
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 2.0 * currentDateTime.day);

    super.initState();
    bookingDate = currentDateTime.toString().split(' ').first;
    id = widget.fieldId;
    getAvailableDates();
  }

  Widget titleView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Text(
        date_util.DateUtils.months[currentDateTime.month - 1] +
            ' ' +
            currentDateTime.year.toString(),
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget hrizontalCapsuleListView() {
    return Container(
      width: width,
      height: 80,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentMonthList.length,
        itemBuilder: (BuildContext context, int index) {
          return capsuleView(index);
        },
      ),
    );
  }

  Widget capsuleView(int index) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
        child: GestureDetector(
          onTap: () {
            // if (index < currentDayOfMonth.day - 1) {
            // } else {
            setState(() {
              currentDateTime = currentMonthList[index];
              bookingDate = currentDateTime.toString().split(' ').first;
              getAvailableDates();
              todoList();
            });
            //}
          },
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: (currentMonthList[index].day != currentDateTime.day)
                        ? [
                            Colors.white.withOpacity(1),
                            Colors.white.withOpacity(1),
                            Colors.white.withOpacity(1),
                          ]
                        : [
                            Color.fromARGB(193, 53, 136, 125),
                            Color.fromARGB(147, 101, 219, 204),
                            HexColor("54D3C2")
                          ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                    stops: const [0.0, 0.5, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 4,
                    spreadRadius: 2,
                    color: Colors.black12,
                  )
                ]),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    currentMonthList[index].day.toString(),
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color:
                            (currentMonthList[index].day != currentDateTime.day)
                                ? Colors.black
                                : Colors.white),
                  ),
                  Text(
                    date_util.DateUtils
                        .weekdays[currentMonthList[index].weekday - 1],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:
                            (currentMonthList[index].day != currentDateTime.day)
                                ? Colors.black
                                : Colors.white),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget topView() {
    return Container(
      width: width,
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [
        //     d_green.withOpacity(0.7),
        //     d_green.withOpacity(0.5),
        //     d_green.withOpacity(0.3)
        //   ],
        //   begin: const FractionalOffset(0.0, 0.0),
        //   end: const FractionalOffset(0.0, 1.0),
        //   stops: const [0.0, 0.5, 1.0],
        //   tileMode: TileMode.clamp,
        // ),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              blurRadius: 1.2,
              color: Colors.black12,
              offset: Offset(1, 1),
              spreadRadius: 1.2)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          titleView(),
          hrizontalCapsuleListView(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  String bookingDateTime = '';
  void getAvailableDates() async {
    var datesList = await Provider.of<FieldsProvider>(context, listen: false)
        .getAvailabale(id, bookingDate);

    setState(() {
      dates = datesList;
      print(dates.runtimeType);
    });
  }

  void bookField() async {
    print(bookingDateTime);
    try {
      await Provider.of<FieldsProvider>(context, listen: false).addBooking(
        fieldId: id,
        startDate: bookingDateTime,
      );
      setState(() {
        getAvailableDates();
      });
    } catch (error) {
      print(error.toString());
    }
  }

  void _showValidationDialog(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text("booking validation"),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () async {
              setState(() {
                bookingDateTime = bookingDate + ' ' + dates[index].toString();
                bookField();
              });
              Navigator.of(ctx).pop();
            },
          ),
          FlatButton(
            child: Text('cancel'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                child: Column(
                  children: [
                    Text(
                      'Booking validation',
                      textScaleFactor: 1.7,
                      style: GoogleFonts.nunito(
                        color: d_green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "date : ${bookingDate}",
                        style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "time : ${dates[index].toString()}",
                        style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () async {
                          setState(() {
                            bookingDateTime =
                                bookingDate + ' ' + dates[index].toString();
                            bookField();
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Book',
                          style: TextStyle(color: d_green),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: d_green),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(color: d_green, spreadRadius: 3),
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

  Widget todoList() {
    if (dates != null) {
      //print(dates[0].toString());

      return Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        //child: Text(currentDateTime.toString()),
        child: ListView.builder(
          itemCount: dates.length,
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {
                showAlertDialog(index);
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 50,
                width: MediaQuery.of(context).size.width / 2,
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
                child: Center(
                  child: Text(
                    dates[index].toString(),
                    style: GoogleFonts.nunito(
                      color: Color.fromARGB(255, 64, 165, 152),
                      fontWeight: FontWeight.w800,
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
            );
            //Text(dates[index].toString());
          },
        ),
      );
    } else {
      return Text(currentDateTime.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        topView(),
        SizedBox(
          height: 30,
        ),
        //Text(bookingDate),
        Text(
          "choose your time from the list",
          style: GoogleFonts.nunito(
            color: Color.fromARGB(255, 4, 5, 5),
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        todoList(),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
