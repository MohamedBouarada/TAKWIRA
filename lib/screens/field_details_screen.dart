// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, import_of_legacy_library_into_null_safe, unused_import, prefer_const_constructors_in_immutables, annotate_overrides, unused_local_variable, avoid_print, no_logic_in_create_state, constant_identifier_names
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:takwira_mobile/widgets/helpContainer.dart';
import '../providers/field/field.dart';
import '../widgets/booking.dart';
import '../providers/field/fields.dart';

const d_green = Color(0xFF54D3C2);

class Details extends StatelessWidget {
  static const routeName = '/Field-details';

  @override
  Widget build(BuildContext context) {
    final fieldId = ModalRoute.of(context)!.settings.arguments as int;
    print(fieldId); // is the id!
    final loadedField = Provider.of<FieldsProvider>(
      context,
      listen: false,
    ).findById(
      fieldId,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    //height: MediaQuery.of(context).size.height / 3,
                    height: 300,
                    width: MediaQuery.of(context).size.width,

                    child: Carousel(
                      dotBgColor: Colors.transparent,
                      dotSize: 6.0,
                      dotSpacing: 15.0,
                      dotPosition: DotPosition.bottomCenter,
                      autoplay: false,
                      images: [
                        Image.network(
                          "https://media.istockphoto.com/photos/tennis-playing-court-picture-id671277978?k=20&m=671277978&s=612x612&w=0&h=0p20LIrZereRi1Y6sLqunUPbt3Y6IINAm02KU4PuWZM=",
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                        Image.asset('assets/images/tennis1.jpg',
                            fit: BoxFit.cover),
                        Image.asset('assets/images/tennis2.jpeg',
                            fit: BoxFit.cover),
                        Image.asset('assets/images/tennis3.jpg',
                            fit: BoxFit.cover),
                      ],
                    ),
                  ),
                  Container(
                    height: 90,
                    color: Colors.transparent,
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 24,
                            right: 24,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.favorite_outline_rounded,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 280,
                      ),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: InfoCard(
                          fieldData: loadedField,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //InfoCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final FieldProvider fieldData;
  const InfoCard({
    Key? key,
    required this.fieldData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 25,
            left: 24,
            right: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fieldData.name,
                style: GoogleFonts.nunito(
                  color: Color.fromARGB(255, 64, 165, 152),
                  fontWeight: FontWeight.w800,
                  fontSize: 23,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: d_green,
                    size: 25,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    fieldData.adresse,
                    style: GoogleFonts.nunito(
                      color: Color.fromARGB(179, 15, 14, 14),
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        color: d_green,
                        size: 14.0,
                      ),
                      Text(
                        '12 km ',
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
              SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RatingBar(
                    4.round(),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "4.5",
                    style: GoogleFonts.nunito(
                        color: Color.fromARGB(179, 39, 37, 37),
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        CardBody(
          fieldBody: fieldData,
        ),
      ],
    );
  }
}

class CardBody extends StatefulWidget {
  final FieldProvider fieldBody;
  const CardBody({Key? key, required this.fieldBody}) : super(key: key);

  @override
  State<CardBody> createState() => _CardBodyState();
}

class _CardBodyState extends State<CardBody> {
  late Widget view = InfoField(
    fieldInfo: widget.fieldBody,
  );
  String button = "infosfield";

  void handleShow() {
    if (button == "infosfield") {
      setState(() {
        view = InfoField(
          fieldInfo: widget.fieldBody,
        );
      });
    } else {
      setState(() {
        view = Booking();
      });
    }
  }

  void initState() {
    super.initState();
    handleShow();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Container(
              width: (MediaQuery.of(context).size.width - 30) / 2,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: (button == 'infosfield')
                        ? d_green
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(10.0),
                  primary: (button == 'infosfield')
                      ? Colors.black
                      : Color.fromARGB(179, 15, 14, 14),
                  textStyle: const TextStyle(
                    fontSize: 17,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    button = "infosfield";
                    handleShow();
                  });
                },
                child: const Text(
                  'Info Field',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width - 30) / 2,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: (button == '') ? d_green : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(10.0),
                  primary: (button == '')
                      ? Colors.black
                      : Color.fromARGB(179, 15, 14, 14),
                  textStyle: const TextStyle(
                    fontSize: 17,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    button = "";
                    handleShow();
                  });
                },
                child: const Text(
                  'Booking',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        view,
      ],
    );
  }
}

class InfoField extends StatelessWidget {
  final FieldProvider fieldInfo;
  const InfoField({Key? key, required this.fieldInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              FeaturesTile(
                icon: Icon(Icons.car_repair, color: Color(0xff5A6C64)),
                label: "Parking",
              ),
              FeaturesTile(
                icon: Icon(Icons.coffee, color: Color(0xff5A6C64)),
                label: "Coffee",
              ),
              FeaturesTile(
                icon: Icon(Icons.wifi, color: Color(0xff5A6C64)),
                label: "Free Wifi",
              ),
              FeaturesTile(
                icon: Icon(Icons.wifi, color: Color(0xff5A6C64)),
                label: "Free Wifi",
              ),
              FeaturesTile(
                icon: Icon(Icons.wifi, color: Color(0xff5A6C64)),
                label: "Free Wifi",
              ),
              FeaturesTile(
                icon: Icon(Icons.wifi, color: Color(0xff5A6C64)),
                label: "Free Wifi",
              ),
              FeaturesTile(
                icon: Icon(Icons.wifi, color: Color(0xff5A6C64)),
                label: "Free Wifi",
              ),
              FeaturesTile(
                icon: Icon(Icons.local_drink, color: Color(0xff5A6C64)),
                label: "Drinks",
              ),
            ],
          ),
        ),
        // Container(
        //   margin: EdgeInsets.symmetric(vertical: 24),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [DetailsCard(), DetailsCard()],
        //   ),
        // ),
        SizedBox(
          height: 12,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "taieb mhiri terrain mezyen yeser , s7i7 9dim chwaya ama jawou behi , yhez 12000 ,allah ghaleb heka 7adou, bo93tou mezyena yeser w 9rib lkol chay .thama parking w wifi w cafe w bar ba3d takwira -> jaw lkol mawjoud w disponible a tous moments ",
            //fieldInfo.description,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 15,
                height: 1.5,
                fontWeight: FontWeight.w600,
                color: Color(0xff879D95)),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        HelpContainer(),
      ],
    );
  }
}

// class DetailsCard extends StatelessWidget {
//   final String? title;
//   final String? noOfReviews;
//   final double? rating;
//   DetailsCard({this.rating, this.title, this.noOfReviews});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//           color: Color(0xffE9F4F9), borderRadius: BorderRadius.circular(16)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                     color: Color(0xffD5E6F2),
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Image.asset(
//                   "assets/name1.png",
//                   height: 30,
//                 ),
//               ),
//               SizedBox(
//                 width: 8,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Booking",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xff5A6C64)),
//                   ),
//                   SizedBox(
//                     height: 6,
//                   ),
//                   Text(
//                     "8.0/10",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xff5A6C64)),
//                   )
//                 ],
//               )
//             ],
//           ),
//           SizedBox(
//             height: 8,
//           ),
//           Text(
//             " Based on 30 reviews",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xff879D95)),
//           ),
//         ],
//       ),
//     );
//   }
// }

class FeaturesTile extends StatelessWidget {
  final Icon? icon;
  final String? label;
  FeaturesTile({this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        width: 90,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff5A6C64).withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(40)),
              child: icon,
            ),
            SizedBox(
              height: 9,
            ),
            Container(
                width: 70,
                child: Text(
                  label!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff5A6C64)),
                ))
          ],
        ),
      ),
    );
  }
}

class RatingBar extends StatelessWidget {
  final int rating;
  RatingBar(this.rating);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          color: rating >= 1 ? d_green : Color.fromARGB(129, 128, 231, 217),
        ),
        SizedBox(
          width: 3,
        ),
        Icon(
          Icons.star,
          color: rating >= 2 ? d_green : Color.fromARGB(129, 128, 231, 217),
        ),
        SizedBox(
          width: 3,
        ),
        Icon(
          Icons.star,
          color: rating >= 3 ? d_green : Color.fromARGB(129, 128, 231, 217),
        ),
        SizedBox(
          width: 3,
        ),
        Icon(
          Icons.star,
          color: rating >= 4 ? d_green : Color.fromARGB(129, 128, 231, 217),
        ),
        SizedBox(
          width: 3,
        ),
        Icon(
          Icons.star,
          color: rating >= 5 ? d_green : Color.fromARGB(129, 128, 231, 217),
        ),
      ],
    ));
  }
}
