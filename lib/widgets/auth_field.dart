import 'package:flutter/material.dart';

Widget makeInput({label, obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      TextField(
        obscureText: obscureText,
        style: TextStyle(color: Color.fromARGB(255, 9, 77, 9), fontSize: 16),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: label,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
        ),
      ),
      SizedBox(
        height: 30,
      ),
    ],
  );
}
