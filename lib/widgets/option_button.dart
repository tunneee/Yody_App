/*
 * Option Buttons
 * *
 * Include Icons - Heading - Icons
 */
import 'package:flutter/material.dart';
import '../controls/app.dart';
import '../models/constants.dart';

class OptionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function click;
  const OptionButton(
      {Key? key, required this.icon, required this.label, required this.click})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: BoxSpace.paddingDefault,
          vertical: BoxSpace.paddingDefault / 3),
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: App.sbgc,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            shadowColor: ColorPalette.darkColor,
            primary: App.sfgc,
            padding: EdgeInsets.symmetric(
                horizontal: BoxSpace.paddingDefault,
                vertical: BoxSpace.paddingDefault / 1.4),
          ),
          onPressed: () {
            click();
          },
          child: Row(children: [
            Icon(icon),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              label,
              style: TextStyle(fontSize: 18),
            )),
            Icon(
              Icons.arrow_right_rounded,
              size: 30,
            )
          ])),
    );
  }
}
