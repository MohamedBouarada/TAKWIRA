// ignore_for_file: prefer_const_constructors, prefer_is_empty, unnecessary_new, unnecessary_this, deprecated_member_use

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takwira_mobile/screens/field_add_screen.dart';
import 'package:takwira_mobile/screens/field_edit_screen.dart';
import '../providers/field.dart';
import '../themes/color.dart';
import 'package:http/http.dart' as http;

class IndexPage extends StatefulWidget {
  static const routName = '/fields-list';
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List fields = [];
  Map<String, dynamic> listTest = {
    "startDate": "2022-04-12",
    "finishDate": "2022-04-22"
  };
  bool isLoading = false;
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
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
    var url = "http://10.0.2.2:5000/field/getByOwner/1";
    var response = await http.get(
      Uri.parse(url),
      headers: requestHeaders,
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
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Color(0x665ac18e),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FieldAdd()));
              },
              child: Text(
                'Add Field    ',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ))
        ],
      ),
      body: getBody(),
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
        });
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
        height: MediaQuery.of(context).size.height / 5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(48, 90, 193, 141),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              offset: Offset(1.0, 1.0),
              color: Color.fromARGB(45, 90, 193, 141),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("http://10.0.2.2:5000/static/"+images[0]['name']),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              margin: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  // SizedBox(
                  //   height: 3,
                  // ),
                  // Text(
                  //   desc,
                  //   style: TextStyle(
                  //       fontSize: 13,
                  //       fontWeight: FontWeight.w400,
                  //       color: Color(0xff89A097)),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${item['prix']}DT",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                                            unavailability['startDate']
                                                .toString(),
                                        unavailabilityFinishDate:
                                            unavailability['finishDate']
                                                .toString(),
                                        description: item['description'],
                                        services: item['services'],
                                        period: item['period'],
                                        surface: item['surface'],
                                        opening: item['ouverture'],
                                        closing: item['fermeture'],
                                        location: item['localisation'],
                                        images: item['images'],
                                      )));
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
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
                ],
              ),
            ),
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
    //           //       ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
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
