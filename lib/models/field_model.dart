// ignore_for_file: non_constant_identifier_names, unnecessary_import

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List<FieldModel> FieldsFromJson(dynamic str) =>
    List<FieldModel>.from(json.decode(str).map((x) => FieldModel.fromJson(x)));

class FieldModel with ChangeNotifier {
  final int id;
  final String name;
  final String adresse;
  final String type;
  final String isNotAvailable;
  final String services;
  final double price;
  final String period;
  final String surface;
  final String description;
  final int idProprietaire;
  // final DateTime? createdAt;
  // final DateTime? updatedAt;

  //late String? FieldImage;

  FieldModel({
    required this.id,
    required this.name,
    required this.adresse,
    required this.type,
    required this.services,
    required this.price,
    required this.description,
    required this.idProprietaire,
    required this.isNotAvailable,
    required this.surface,
    required this.period,
    // this.createdAt,
    // this.updatedAt,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) => FieldModel(
        id: json['id'],
        name: json['name'],
        adresse: json['adresse'],
        type: json['type'],
        isNotAvailable: json['availibility'],
        services: json['services'],
        price: json['prix'],
        period: json['period'],
        surface: json['surface'],
        description: json['description'],
        idProprietaire: json['idProprietaire'],
        // createdAt: json['createdAt'],
        // updatedAt: json['updatedAt'],
      );
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['adresse'] = adresse;
    _data['type'] = type;
    _data['services'] = services;
    _data['price'] = price;
    _data['description'] = description;
    _data['idProprietaire'] = idProprietaire;
    _data['isNotAvailable'] = isNotAvailable;
    _data['surface'] = surface;
    _data['period'] = period;
    return _data;
  }
}
