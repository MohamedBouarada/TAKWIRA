import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/widgets.dart';
import "../models/http_exception.dart";

class Auth with ChangeNotifier {
  String _token = "";
  late DateTime _expiryDate = DateTime.now();

  String get token {
    if (_expiryDate.isAfter(DateTime.now()) && _token != "") {
      return _token;
    }
    return "";
  }

  bool get isAuth {
    return token != "";
  }

  Future<void> signup({
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String password,
  }) async {
    const url = 'http://10.0.2.2:5000/client/add';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(
          {
            'email': email,
            'firstName': firstName,
            'lastName': lastName,
            'phoneNumber': phoneNumber,
            'password': password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (response.statusCode != HttpStatus.created) {
        throw HttpException(responseData);
      }
    } catch (error) {
      print("**************");
      print(error.toString());
      rethrow;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    const url = 'http://10.0.2.2:5000/client/login';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (response.statusCode != HttpStatus.ok) {
        throw HttpException(responseData);
      }
      _token = responseData;
      _expiryDate = DateTime.now().add(
        const Duration(days: 3),
      );
      notifyListeners();
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}
