/*
 * MainPage
 * *
 * Feature
 * Foundation Page
 * Bottombar Navigaton
 */
import 'package:clothing_store_app_ui/screens/camera_page.dart';
import 'package:clothing_store_app_ui/models/constants.dart';
import 'package:clothing_store_app_ui/screens/home.dart';
import 'package:clothing_store_app_ui/screens/user_page.dart';
import 'package:flutter/material.dart';
import 'controls/app.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //
  // ***
  // Navigation Widgets and Index
  // Include Home, CameraPage, UserPage
  // ***
  //
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    CameraPage(),
    UserPage(),
  ];

  //
  // ***
  // Handle Changing Bottombar Index
  // ***
  //
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App.bgc,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                color: ColorPalette.shadeColor,
                spreadRadius: 0,
                blurRadius: 5.0,
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              //
              // ***
              // Bottombar Items
              // Include Home, Camera, Person
              // ***
              //
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                    size: 30.0,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.camera_enhance,
                    size: 30.0,
                  ),
                  label: "Magic Cam",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_rounded,
                    size: 30.0,
                  ),
                  label: "User",
                ),
              ],
              currentIndex: _selectedIndex,
              unselectedItemColor: ColorPalette.darkColor,
              selectedItemColor: App.mainc,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
