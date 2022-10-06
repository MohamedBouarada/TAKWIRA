// ignore_for_file: prefer_const_constructors, annotate_overrides, unnecessary_new, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, constant_identifier_names, avoid_unnecessary_containers, unused_local_variable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/field/field.dart';
import '../widgets/calendar.dart';
import '../themes/color.dart';
import 'field_details_screen.dart';
import '../providers/field/fields.dart';

const d_green = Color(0xFF54D3C2);

class ClientFieldScreen extends StatelessWidget {
  const ClientFieldScreen({Key? key}) : super(key: key);
  static const routeName = '/client-fieldsList';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          SearchSection(),
          FieldsSection(),
        ]),
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
        onPressed: null,
      ),
      title: Text(
        'BO3',
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.favorite_outline_rounded,
            color: Colors.grey[800],
            size: 25,
          ),
          onPressed: null,
        ),
        IconButton(
          icon: Icon(
            Icons.place,
            color: Colors.grey[800],
            size: 25,
          ),
          onPressed: null,
        ),
      ],
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}

class SearchSection extends StatelessWidget {
  const SearchSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBgColor,
      padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Hammamet',
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    )
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CalendarPage();
                      },
                    );
                  },
                  child: Icon(
                    Icons.search,
                    size: 26,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(10),
                    primary: d_green,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'choose date',
                      style: GoogleFonts.nunito(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '12 Dec - 22 dec',
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    )
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CalendarPage();
                      },
                    );
                  },
                  child: Icon(
                    Icons.calendar_month,
                    size: 26,
                    color: d_green,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(10),
                    primary: white,
                  ),
                ),
              ),
              //       IconButton(
              //   icon: Icon(
              //     Icons.calendar_month,
              //     color: d_green,
              //     size: 30,
              //   ),
              //   onPressed: null,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class FieldsSection extends StatefulWidget {
  @override
  State<FieldsSection> createState() => _FieldsSectionState();
}

class _FieldsSectionState extends State<FieldsSection> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<FieldsProvider>(context).fetchAndSetFields().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  final List fieldsList = [
    {
      'title': 'juve',
      'place': 'hammamet',
      'distance': 2,
      'review': 36,
      'picture': 'assets/images/tennis1.jpg',
      'price': '180',
      "is_favorited": true,
    },
    {
      'title': 'aliance',
      'place': 'nabeul',
      'distance': 5,
      'review': 12,
      'picture': 'assets/images/tennis3.jpg',
      'price': '100',
      "is_favorited": false,
    },
    {
      'title': 'taktik',
      'place': 'Sfax',
      'distance': 9,
      'review': 6,
      'picture': 'assets/images/tennis.jpg',
      'price': '80',
      "is_favorited": false,
    },
    {
      'title': 'ka7la',
      'place': 'hammamet',
      'distance': 13,
      'review': 16,
      'picture': 'assets/images/tennis2.jpeg',
      'price': '90',
      "is_favorited": false,
    }
  ];

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<FieldsProvider>(context);
    final products = productsData.items;
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '4 fields found',
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Filters',
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.filter_list_outlined,
                        color: d_green,
                        size: 25,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: products.map((field) {
              return FieldCard(
                fieldData: field,
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => Details(
                  //       imgUrl:
                  //           'http://images.pexels.com/photos/1659438/pexels-photo-1659438.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                  //       placeName: 'hammamet',
                  //       rating: 4.5,
                  //     ),
                  //   ),
                  // );
                  Navigator.of(context).pushNamed(
                    Details.routeName,
                    arguments: field.id,
                  );
                },
                onTapFavorite: () {
                  setState(() {
                    field.isFavorite = !field.isFavorite;
                    //field["is_favorited"] = !field["is_favorited"];
                  });
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class FieldCard extends StatelessWidget {
  final FieldProvider fieldData;
  //final Map fieldData;
  final GestureTapCallback? onTapFavorite;
  final GestureTapCallback? onTap;
  const FieldCard(
      {Key? key, required this.fieldData, this.onTapFavorite, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var images = json.decode(fieldData.images);

    //print(images[0]['name'].toString());
    // print(fieldData.price.toString());
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        height: 250,
        width: double.infinity,
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
        child: Column(
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                      "http://${dotenv.env['addressIp']}:5000/static/" +
                          images[0]['name']),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 5,
                    right: -15,
                    child: MaterialButton(
                      color: Colors.white,
                      shape: CircleBorder(),
                      onPressed: onTapFavorite,
                      child: Icon(
                        fieldData.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_outline_rounded,
                        color: fieldData.isFavorite ? actionColor : d_green,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    fieldData.name,
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    fieldData.price.toString() + 'DT',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    fieldData.adresse,
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        color: d_green,
                        size: 14.0,
                      ),
                      Text(
                        //distance
                        fieldData.price.toString() + ' km ',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 3, 10, 0),
              child: Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star_rate,
                        color: d_green,
                        size: 14,
                      ),
                      Icon(
                        Icons.star_rate,
                        color: d_green,
                        size: 14,
                      ),
                      Icon(
                        Icons.star_rate,
                        color: d_green,
                        size: 14,
                      ),
                      Icon(
                        Icons.star_rate,
                        color: d_green,
                        size: 14,
                      ),
                      Icon(
                        Icons.star_border,
                        color: d_green,
                        size: 14.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    //reviews
                    fieldData.price.toString() + ' reviews',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'per 1 hour',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
