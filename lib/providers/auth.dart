import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "../models/http_exception.dart";

class Auth with ChangeNotifier {
  late String _token = "";
  late DateTime _expiryDate;

  Future<bool?> get token async {
    final prefs = await SharedPreferences.getInstance();
    print('***********');
    print(prefs.getString('token'));
    final String? value = prefs.getString('token');
    return value != null;
  }

  bool get isAuth {
    print(token);
    return false;
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
      final prefs = await SharedPreferences.getInstance();

// Save an integer value to 'counter' key.
      await prefs.setString('token', responseData);
      /* _expiryDate = DateTime.now().add(
        const Duration(days: 3),
      );
      */
      print(_token);
      notifyListeners();
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}
