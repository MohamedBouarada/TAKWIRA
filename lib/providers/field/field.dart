import 'dart:ffi';

import 'package:flutter/foundation.dart';

class FieldProvider with ChangeNotifier {
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
  final String localisation;
  final int userId;
  final String images;
  bool isFavorite;
  // final DateTime? createdAt;
  // final DateTime? updatedAt;

  //late String? FieldImage;

  FieldProvider({
    required this.id,
    required this.name,
    required this.adresse,
    required this.type,
    required this.services,
    required this.price,
    required this.description,
    required this.isNotAvailable,
    required this.surface,
    required this.period,
    required this.localisation,
    required this.userId,
    required this.images,
    this.isFavorite = false,
    // this.createdAt,
    // this.updatedAt,
  });
  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
