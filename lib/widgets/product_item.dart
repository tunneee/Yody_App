import 'dart:ui';
import 'package:clothing_store_app_ui/screens/detail.dart';
import 'package:clothing_store_app_ui/models/product.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductItems extends StatelessWidget {
  late Product products;
  ProductItems({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Detail(product: products),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'images/${products.images[0]}',
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 7.0),
                  decoration: BoxDecoration(
                    color: Colors.white12.withOpacity(0.1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            products.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${products.price.toInt()} VNĐ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Nhấp vào để xem thêm",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.white),
                          Text(
                            "4.5",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
