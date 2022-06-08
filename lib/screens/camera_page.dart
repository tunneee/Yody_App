/*
 * CameraPage
 * *
 * Access Camera Zone 
 */
import 'package:camera/camera.dart';
import 'package:clothing_store_app_ui/screens/camera.dart';
import 'package:clothing_store_app_ui/models/constants.dart';
import 'package:flutter/material.dart';
import '../controls/app.dart';

class CameraPage extends StatelessWidget {
  final String productId = "";
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App.bgc,
      body: Padding(
        padding: const EdgeInsets.all(BoxSpace.paddingDefault * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //
            // ***
            // Introduce to Camera
            // Image of Yody, Camera, Heading, SubHeading, Access Camera Button
            // ***
            //
            SizedBox(height: 50, child: Image.asset('images/logo.png')),
            SizedBox(
              height: BoxSpace.paddingDefault * 2,
            ),
            Container(
              height: 100,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("images/camera.png"))),
            ),
            SizedBox(
              height: BoxSpace.paddingDefault,
            ),
            Text(
              "Magic Camera",
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: App.fgc),
            ),
            SizedBox(
              height: BoxSpace.paddingDefault,
            ),
            Padding(
              padding: const EdgeInsets.all(BoxSpace.paddingDefault),
              child: Text(
                "Magic camera allow you to try out Yody Clothes to get suitable outfit for everyone.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: App.fgc,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: BoxSpace.paddingDefault * 3,
            ),
            MaterialButton(
              onPressed: () async {
                //
                // ***
                // Access Camera Button
                // Do something here
                // ***
                //
                await availableCameras().then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Camera(
                              cameras: value,
                            ))));
              },
              height: 66,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              textColor: Colors.white,
              padding: EdgeInsets.all(0.0),
              child: Container(
                height: 66,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                    colors: [
                      Color.alphaBlend(Colors.white24, ColorPalette.yodyyellow),
                      ColorPalette.yodyyellow,
                    ],
                  ),
                ),
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "Launch Magic Camera",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
