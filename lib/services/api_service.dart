// ignore_for_file: non_constant_identifier_names, avoid_print, unnecessary_new

import 'dart:convert';
import 'dart:io';

import '../models/field_model.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';

class APIService {
  static var client = http.Client();

  static Future<List<FieldModel>> getFields() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.fieldsAPI + "/getByOwner/1",
    );
    print(url);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    //print(response.body);
    if (response.statusCode == 200) {
      List dataresponse = await json.decode(response.body);
      //print(dataresponse);
      return dataresponse.map((data) => new FieldModel.fromJson(data)).toList();

      //return true;
    } else {
      return [];
    }
  }

  static Future<bool> saveField(
    FieldModel model,
    bool isEditMode,
    bool isFileSelected,
  ) async {
    var FieldURL = Config.fieldsAPI;

    if (isEditMode) {
      FieldURL = FieldURL + "/" + model.id.toString();
    }

    var url = Uri.http(Config.apiURL, FieldURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["FieldName"] = model.name!;
    request.fields["FieldAddress"] = model.adresse!;
    request.fields["FieldType"] = model.type!;
    request.fields["FieldDescription"] = model.description!.toString();
    request.fields["FieldIdOwner"] = model.idProprietaire!.toString();
    request.fields["FieldSurface"] = model.surface!;

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // static Future<bool> deleteField(FieldId) async {
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //   };

  //   var url = Uri.http(
  //     Config.apiURL,
  //     Config.fieldsAPI + "/" + FieldId,
  //   );

  //   var response = await client.delete(
  //     url,
  //     headers: requestHeaders,
  //   );

  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
