// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/widgets.dart';
import 'package:takwira_mobile/models/storage_item.dart';
import 'package:takwira_mobile/providers/storage_service.dart';

import "../models/http_exception.dart";

class Auth with ChangeNotifier {
  Future<void> signup({
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String password,
  }) async {
    const url = 'http://10.0.2.2:5000/user/add';
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
            'role':"CLIENT"
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
    const url = 'http://10.0.2.2:5000/user/login';
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

// Save an integer value to 'counter' key.
      final StorageService _storageService = StorageService();
      final StorageItem storageItem = StorageItem('token', responseData);
      _storageService.writeSecureData(storageItem);
      notifyListeners();
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}
