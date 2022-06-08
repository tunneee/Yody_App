import 'package:clothing_store_app_ui/models/constants.dart';
import 'package:flutter/material.dart';

class DisCoverCircle extends StatelessWidget {
  final String image;
  final String title;
  const DisCoverCircle({Key? key, required this.image, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: BoxSpace.paddingDefault,
          right: BoxSpace.paddingSmall,
          bottom: BoxSpace.paddingSmall,
          left: BoxSpace.paddingDefault),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            child: PhysicalShape(
              color: Colors.white,
              shadowColor: Colors.black,
              clipBehavior: Clip.hardEdge,
              elevation: 3,
              clipper: ShapeBorderClipper(
                shape: CircleBorder(),
              ),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/${image}'),
                )),
              ),
            ),
          ),
          SizedBox(height: 7.0),
          Text(
            title,
            style: TextStyle(
              color: Color(0xffadafaf),
            ),
          )
        ],
      ),
    );
    ;
  }
}
