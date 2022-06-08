import 'package:clothing_store_app_ui/models/constants.dart';
import 'package:clothing_store_app_ui/models/categories.dart';
import 'package:clothing_store_app_ui/models/product.dart';

class MockedDataCategories {
  static List<Category> data = [
    Category(
        Id: 0001,
        name: 'Thời trang Nữ',
        detail: 'Style for Woman. Berrylush Collection',
        image: 'woman.jpg',
        color: ColorPalette.berrylush,
        products: [
          Product(
              Id: 1001,
              name: 'Sơ mi',
              detail: 'Mã: SMM3011-XNH-M',
              images: [
                "1.jpg",
                "2.jpg",
                "3.jpg",
                "4.jpg",
              ],
              price: 500000,
              colors: [
                ColorPalette.lavender,
                ColorPalette.naviblue,
                ColorPalette.coralred
              ]),
          Product(
              Id: 1001,
              name: 'Áo trẻ em',
              detail: 'Mã: SMM3011-XNH-M',
              images: [
                "kid 1.jpg",
                "kid 2.jpg",
                "kid 3.jpg",
                "kid 4.jpg",
              ],
              price: 120000,
              colors: [ColorPalette.berrylush]),
          Product(
              Id: 1001,
              name: 'Áo cặp',
              detail: 'Mã: SMM3011-XNH-M',
              images: [
                "23.jpg",
                "2.jpg",
                "3.jpg",
                "4.jpg",
              ],
              price: 400000,
              colors: [
                ColorPalette.berrylush,
                ColorPalette.naviblue,
                ColorPalette.coralred
              ]),
          Product(
              Id: 1001,
              name: 'Giày lười',
              detail: 'Mã: SMM3011-XNH-M',
              images: [
                "shoes.jpg",
                "2.jpg",
                "3.jpg",
                "4.jpg",
              ],
              price: 900000,
              colors: [
                ColorPalette.berrylush,
                ColorPalette.naviblue,
                ColorPalette.coralred
              ]),
        ]),
    Category(
        Id: 0002,
        name: 'Thời trang nam',
        detail: 'Style for Man. Yody Collection',
        image: 'man 2.jpg',
        color: ColorPalette.yodyyellow,
        products: []),
    Category(
        Id: 0003,
        name: 'Giày',
        detail: 'Shoes. Yody Collection',
        image: 'shoes.jpg',
        color: ColorPalette.yodyblue,
        products: []),
    Category(
        Id: 0004,
        name: 'Thời trang trẻ em',
        detail: 'Style for Kid. Yody Collection',
        image: 'kid.jpg',
        color: ColorPalette.yodyyellow,
        products: []),
    Category(
        Id: 0004,
        name: 'Áo quần thể thao',
        detail: 'Sports. Yody Collection',
        image: 'sports.png',
        color: ColorPalette.yodyyellow,
        products: []),
    Category(
        Id: 0004,
        name: 'Phụ kiện',
        detail: 'Accessories. Yody Collection',
        image: 'accessories.png',
        color: ColorPalette.yodyyellow,
        products: [])
  ];
}
