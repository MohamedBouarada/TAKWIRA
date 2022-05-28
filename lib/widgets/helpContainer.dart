// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpContainer extends StatelessWidget {
  const HelpContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF54D3C2),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            height: 30,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Besoin d aide?",
            style: GoogleFonts.nunito(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              "Nous sommes à votre disposition pour répondre à vos questions",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
