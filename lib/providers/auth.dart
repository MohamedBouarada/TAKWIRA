import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
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
      print(error.toString());
      rethrow;
    }
  }
}
