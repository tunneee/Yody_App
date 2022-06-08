/*
 * HomePage 
 * *
 * Feature: 
 * Interactive Welcome Heading
 * Open Shopping Card List
 * Open Categories to view Product Items
 * Open Product Details
 */
import 'package:clothing_store_app_ui/widgets/product_item.dart';
import 'package:clothing_store_app_ui/models/categories.dart';
import 'package:clothing_store_app_ui/services/mocked_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../models/constants.dart';
import '../widgets/discover-circle.dart';
import '../controls/app.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List<Category> categories = MockedDataCategories.data;
    return Scaffold(
      backgroundColor: App.bgc,

      //
      // ***
      // Navigation bar Container
      // Include Burger Menu and Shopping cart list
      // ***
      //
      appBar: AppBar(
        elevation: 0,
        backgroundColor: App.bgc,
        foregroundColor: App.mainc,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.menu,
        //     color: App.mainc,
        //   ),
        //   onPressed: () {
        //     //
        //     // ***
        //     // Burger menu
        //     // Do something here
        //     // ***
        //     //
        //   },
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                //
                // ***
                // Shopping Cart List
                // Do something here
                // ***
                //
              },
              child: Container(
                height: 30,
                width: 30,
                child: PhysicalShape(
                  color: App.bgc,
                  shadowColor: ColorPalette.darkColor,
                  elevation: 2,
                  clipper: ShapeBorderClipper(
                    shape: CircleBorder(),
                  ),
                  child: Icon(
                    Icons.shopping_bag_rounded,
                    color: App.mainc,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      //
      // ***
      // HomePage List view
      // Include Heading, Horizontal Categories, Search, Product Items
      // ***
      //
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          //
          // ***
          // Big Heading
          // Welcome words, Sorting and subHeading
          // ***
          //
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: BoxSpace.paddingDefault),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Big heading
                Column(
                  children: [
                    Text(
                      "Yody xin chào!",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: App.fgc,
                      ),
                    )
                  ],
                ),
                // Sorting
                TextButton(
                  onPressed: () {
                    //
                    // ***
                    // Sorting Button
                    // Do something here
                    // ***
                    //
                  },
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, primary: App.mainc),
                  child: Row(
                    children: [
                      Text(
                        "Sắp xếp",
                        style: TextStyle(
                          color: App.mainc,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: App.mainc,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Subheading
          Padding(
            padding: const EdgeInsets.only(left: BoxSpace.paddingDefault),
            child: Text(
              "Thương hiệu thời gian công nghệ",
              style: TextStyle(color: App.mdc),
            ),
          ),

          //
          // ***
          // Horizontal Categories
          // Include Heading, Horizontal Categories, Search, Product Items
          // ***
          //
          Container(
            height: 120,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => DisCoverCircle(
                  image: categories[index].image,
                  title: categories[index].name),
            ),
          ),

          //
          // ***
          // Searching Box
          // Include search box
          // ***
          //
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: BoxSpace.paddingDefault),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(BoxSpace.paddingSmall),
                prefixIcon: Icon(
                  Icons.search,
                  color: App.mainc,
                ),
                hintText: "Tìm kiếm sản phẩm",
                hintStyle: TextStyle(
                  color: App.mainc,
                ),
                fillColor: App.bgc,
                filled: true,
                suffixIcon: Container(
                  padding: EdgeInsets.all(8.0),
                  child: PhysicalShape(
                    color: App.mainc,
                    shadowColor: ColorPalette.shadeColor,
                    elevation: 2,
                    clipper: ShapeBorderClipper(
                      shape: CircleBorder(),
                    ),
                    child: Icon(
                      Icons.sync_alt,
                      color: App.bgc,
                      size: 20,
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          //
          // ***
          // Product Items
          // Include StaggeredGridView
          // Listed by Trending Products
          // ***
          //
          Padding(
            padding: const EdgeInsets.all(BoxSpace.paddingDefault),
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: categories[0].products.length,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) =>
                  ProductItems(products: categories[0].products[index]),
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.count(2, index.isEven ? 3 : 2),
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
            ),
          )
        ],
      ),
    );
  }
}
