import 'package:flutter/material.dart';

class Product {
  late double Id;
  late String name;
  late String detail;
  late List<String> images;
  late double price;
  late List<Color> colors;

  Product({
    required this.Id,
    required this.name,
    required this.detail,
    required this.images,
    required this.price,
    required this.colors,
  });
}
