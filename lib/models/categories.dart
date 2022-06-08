import 'package:clothing_store_app_ui/models/product.dart';
import 'package:flutter/material.dart';

class Category {
  late double Id;
  late String name;
  late String detail;
  late String image;
  late Color color;
  late List<Product> products;

  Category(
      {required this.Id,
      required this.name,
      required this.detail,
      required this.image,
      required this.color,
      required this.products});
}
