import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import '../models/field_model.dart';

class Fields with ChangeNotifier {
  static List<FieldModel> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'http://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'http://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'http://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'http://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  // var _showFavoritesOnly = false;

  List<FieldModel> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }

    return [..._items];
  }

  // List<FieldModel> get favoriteItems {
  //   return _items.where((prodItem) => prodItem.isFavorite).toList();
  // }

  FieldModel findById(int id) {
    return _items.firstWhere((field) => field.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }
  static Future<List<FieldModel>> getFields() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = "http://${dotenv.env['addressIp']}:5000/field/getByOwner/1";
    print(url);
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: requestHeaders,
      );
      final extractedData = json.decode(response.body) as List;
      // ignore: unnecessary_null_comparison
      if (extractedData == null) {
        return [];
      }

      final List<FieldModel> loadedProducts = [];

      for (var i = 0; i < extractedData.length; i++) {
        loadedProducts.add(FieldModel(
          id: extractedData[i]['id'],
          name: extractedData[i]['name'],
          adresse: extractedData[i]['adresse'],
          type: extractedData[i]['type'],
          services: extractedData[i]['services'],
          price: extractedData[i]['price'],
          description: extractedData[i]['description'],
          idProprietaire: extractedData[i]['idProprietaire'],
          isNotAvailable: extractedData[i]['isNotAvailable'],
          surface: extractedData[i]['surface'],
          period: extractedData[i]['period'],
        ));
      }
      _items = loadedProducts;
      // print(_items);
      return loadedProducts;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchAndSetFields() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = "http://${dotenv.env['addressIp']}:5000/field/getByOwner/1";
    print(url);
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: requestHeaders,
      );
      final extractedData = json.decode(response.body) as List;
      // ignore: unnecessary_null_comparison
      if (extractedData == null) {
        return;
      }
      print(extractedData);
      final List<FieldModel> loadedProducts = [];
      for (var fieldData in extractedData) {
        loadedProducts.add(FieldModel(
          id: fieldData['id'],
          name: fieldData['name'],
          adresse: fieldData['adresse'],
          type: fieldData['type'],
          isNotAvailable: fieldData['isNotAvailable'],
          services: fieldData['services'],
          price: fieldData['price'],
          period: fieldData['period'],
          surface: fieldData['surface'],
          description: fieldData['description'],
          idProprietaire: fieldData['idProprietaire'],
        ));
      }

      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addField(FieldModel field) async {
    final url = Uri.https('flutter-update.firebaseio.com', '/products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': field.name,
          'adresse': field.adresse,
          'type': field.type,
          'isNotAvailable': field.isNotAvailable,
          'services': field.services,
          'price': field.price,
          'period': field.period,
          'surface': field.surface,
          'description': field.description,
          'idProprietaire': field.idProprietaire,
        }),
      );
      final newFiled = FieldModel(
        name: field.name,
        adresse: field.adresse,
        type: field.type,
        isNotAvailable: field.isNotAvailable,
        services: field.services,
        price: field.price,
        period: field.period,
        surface: field.surface,
        description: field.description,
        idProprietaire: field.idProprietaire,
        id: json.decode(response.body)['id'],
      );
      _items.add(newFiled);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> updateField(int id, FieldModel newField) async {
    final fieldIndex = _items.indexWhere((field) => field.id == id);
    if (fieldIndex >= 0) {
      final url =
          'http://${dotenv.env['addressIp']}:5000/field/' + id.toString();
      final response = await http.put(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: json.encode({
            'name': newField.name,
            'adresse': newField.adresse,
            'type': newField.type,
            'isNotAvailable': newField.isNotAvailable,
            'services': newField.services,
            'price': newField.price,
            'period': newField.period,
            'surface': newField.surface,
            'description': newField.description,
            'idProprietaire': newField.idProprietaire,
          }));
      print(response.body);
      _items[fieldIndex] = newField;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteField(int id) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = 'http://${dotenv.env['addressIp']}:5000/field/' + id.toString();

    final existingFieldIndex = _items.indexWhere((field) => field.id == id);

    FieldModel? existingField = _items[existingFieldIndex];
    //var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingFieldIndex);

    final response = await http.delete(
      Uri.parse(url),
      headers: requestHeaders,
    );
    print(json.decode(response.body));
    notifyListeners();
    if (response.statusCode >= 400) {
      _items.insert(existingFieldIndex, existingField);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }

    existingField = null;
  }
}
