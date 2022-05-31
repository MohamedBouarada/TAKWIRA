// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../utils/date_utils.dart' as date_util;
import '../utils/colors_utils.dart';
import 'package:google_fonts/google_fonts.dart';

const d_green = Color(0xFF54D3C2);

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  double width = 0.0;
  double height = 0.0;
  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  DateTime currentDayOfMonth = DateTime.now();
  List<String> todos = <String>[];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 100.0 * currentDateTime.day);
    super.initState();
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
            if (index < currentDayOfMonth.day - 1) {
              
            } else {
              setState(() {
                currentDateTime = currentMonthList[index];
              });
            }
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

  Widget todoList() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, height * 0.38, 10, 10),
      width: width,
      height: height * 0.60,
      child: ListView.builder(
          itemCount: todos.length,
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
              width: width - 20,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.white12,
                        blurRadius: 2,
                        offset: Offset(2, 2),
                        spreadRadius: 3)
                  ]),
              child: Center(
                child: Text(
                  todos[index],
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        topView(),

        //todoList(),
      ],
    );
  }
}
