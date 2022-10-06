// ignore_for_file: prefer_const_constructors, prefer_is_empty, unnecessary_new, unnecessary_this, deprecated_member_use, unnecessary_brace_in_string_interps
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:takwira_mobile/providers/storage_service.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:takwira_mobile/screens/field_add_screen.dart';
import 'package:takwira_mobile/screens/field_edit_screen.dart';
import 'package:takwira_mobile/screens/owner_booking_screen.dart';
import '../models/storage_item.dart';
import '../providers/field.dart';
import '../themes/color.dart';
import 'package:http/http.dart' as http;
import 'package:takwira_mobile/screens/home_page.dart';

class IndexPage extends StatefulWidget {
  static const routName = '/fields-list';
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final StorageService _storageService = StorageService();
  String _token = "";
  List fields = [];
  Map<String, dynamic> listTest = {
    "startDate": "2022-04-12",
    "finishDate": "2022-04-22"
  };
  bool isLoading = false;
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Authorization': "bearer ",
  };
  @override
  void initState() {
    listTest['startDate'] = "2000-04-12";
    print(listTest);
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    setState(() {
      isLoading = true;
    });
    var url = "http://${dotenv.env['addressIp']}:5000/field/getByOwner";
    _token = (await _storageService.readSecureData('token'))!;
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'bearer ${_token}',
      },
    );

    // print(response.body);
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print(items);
      setState(() {
        fields = items;
        isLoading = false;
      });
    } else {
      fields = [];
      isLoading = false;
    }
  }

  DeleteUser(id) async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<Field>(context, listen: false).deleteField(id);

    setState(() {
      this.fetchUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: dark_d_green,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FieldAdd(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                'Add Field',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                //TextStyle(fontSize: 20, color: Colors.black, fontStyle: GoogleFonts.),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getBody(),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () async {
                    final storage = StorageService();

                    final StorageItem storageItem = StorageItem('token', "");
                    final StorageItem roleItem = StorageItem('role', "");
                    storage.writeSecureData(storageItem);
                    storage.writeSecureData(roleItem);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Logout ',
                      style: GoogleFonts.montserrat(
                        color: d_green,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      //TextStyle(fontSize: 20, color: Colors.black, fontStyle: GoogleFonts.),
                    ),
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context)
                        .pushNamed(OwnerBookingScreen.routeName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Bookings ',
                      style: GoogleFonts.montserrat(
                        color: d_green,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      //TextStyle(fontSize: 20, color: Colors.black, fontStyle: GoogleFonts.),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    if (fields.contains(null) || fields.length < 0 || isLoading) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(primary),
      ));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: fields.length,
      itemBuilder: (context, index) {
        return getCard(fields[index]);
      },
    );
  }

  Widget getCard(item) {
    // var email = item['email'];
    // var profileUrl = item['picture']['large'];

    var unavailability = json.decode(item['isNotAvailable']);
    var images = json.decode(item['images']);
    print(images[0]['name']);
    return GestureDetector(
      onTap: () {
        //Add a detail screen

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => FieldEdit(
        //                                    id: item['id'],
        //                                    name: item['name'],
        //                                    type: item['type'],
        //                                    address: item['adresse'],
        //                                    prix: item['prix'].toString(),
        //                                    unavailabilityStartDate:
        //                                        unavailability['startDate']
        //                                            .toString(),
        //                                    unavailabilityFinishDate:
        //                                        unavailability['finishDate']
        //                                            .toString(),
        //                                   description: item['description'],
        //                                   services: item['services'],
        //                                    period: item['period'],
        //                                   surface: item['surface'],
        //                                  )));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height / 2,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(236, 247, 249, 247),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          // color: inActiveColor,
          border:
              Border.all(color: Color.fromARGB(145, 188, 190, 188), width: 4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(20),
            //     bottomLeft: Radius.circular(20),
            //   ),
            Container(
              // margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height / 3.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Color.fromARGB(255, 250, 249, 249).withOpacity(0.5),
                //     spreadRadius: 2,
                //     blurRadius: 2,
                //     offset: Offset(0, 5),
                //   ),
                // ],
                image: DecorationImage(
                  image: NetworkImage(
                      "http://${dotenv.env['addressIp']}:5000/static/" +
                          images[0]['name']),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              item['name'],
              style: GoogleFonts.robotoMono(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "${item['adresse']}",
              // style: TextStyle(
              //   fontSize: 17,
              //   fontWeight: FontWeight.w600,
              //   color: Colors.black,
              // ),
              style: GoogleFonts.nunito(
                fontSize: 18,
                color: Color.fromARGB(255, 127, 127, 127),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: const Icon(Icons.edit),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FieldEdit(
                          id: item['id'],
                          name: item['name'],
                          type: item['type'],
                          address: item['adresse'],
                          prix: item['prix'].toString(),
                          unavailabilityStartDate:
                              unavailability['startDate'].toString(),
                          unavailabilityFinishDate:
                              unavailability['finishDate'].toString(),
                          description: item['description'],
                          services: item['services'],
                          period: item['period'],
                          surface: item['surface'],
                          opening: item['ouverture'],
                          closing: item['fermeture'],
                          location: item['localisation'],
                          images: item['images'],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  //focusColor: Colors.grey,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () async {
                    await DeleteUser(item['id']);
                    // onDelete!(model);
                  },
                ),
              ],
            ),
            //  ),
          ],
        ),
      ),
    );

    // return Card(
    //   elevation: 0,
    //   margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    //   child: Container(
    //     width: 200,
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(50),
    //     ),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Container(
    //           width: 120,
    //           alignment: Alignment.center,
    //           margin: EdgeInsets.all(10),
    //           // child: Image.network(
    //           //   (model!.productImage == null || model!.productImage == "")
    //           //       ? "http://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
    //           //       : model!.productImage!,
    //           //   height: 70,
    //           //   fit: BoxFit.scaleDown,
    //           // ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 item['name'],
    //                 style: const TextStyle(
    //                   color: Colors.black,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               Text(
    //                 "₹${item['prix']}",
    //                 style: const TextStyle(color: Colors.black),
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               Container(
    //                 width: MediaQuery.of(context).size.width - 180,
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   children: [
    //                     GestureDetector(
    //                       child: const Icon(Icons.edit),
    //                       onTap: () {
    //                         Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => FieldEdit(
    //                                       id: item['id'],
    //                                       name: item['name'],
    //                                       type: item['type'],
    //                                       address: item['adresse'],
    //                                       prix: item['prix'].toString(),
    //                                       unavailabilityStartDate:
    //                                           unavailability['startDate']
    //                                               .toString(),
    //                                       unavailabilityFinishDate:
    //                                           unavailability['finishDate']
    //                                               .toString(),
    //                                       description: item['description'],
    //                                       services: item['services'],
    //                                       period: item['period'],
    //                                       surface: item['surface'],
    //                                     )));
    //                       },
    //                     ),
    //                     GestureDetector(
    //                       child: const Icon(
    //                         Icons.delete,
    //                         color: Colors.red,
    //                       ),
    //                       onTap: () async {
    //                         await DeleteUser(item['id']);
    //                         // onDelete!(model);
    //                       },
    //                     ),
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
