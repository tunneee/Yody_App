import 'package:carousel_slider/carousel_slider.dart';
import 'package:clothing_store_app_ui/models/constants.dart';
import 'package:clothing_store_app_ui/main_page.dart';
import 'package:clothing_store_app_ui/models/product.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final Product product;
  const Detail({Key? key, required this.product}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late Color currentColor;

  @override
  void initState() {
    currentColor = widget.product.colors[0];
    super.initState();
  }

  void handleChangeColor(color) {
    setState(() {
      currentColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ***
            // Images Slider
            // ***
            Expanded(
              child: Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    scrollPhysics: ScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    height: double.infinity,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    autoPlay: true,
                  ),
                  items: widget.product.images
                      .map(
                        (image) => Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffb2adca).withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 10.0,
                                offset: -Offset(0, 3),
                              )
                            ],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('images/$image'),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(
                                        //   MaterialPageRoute(
                                        //     builder: (context) => MainPage(),
                                        //   ),
                                        );
                                  },
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: currentColor,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.filter_center_focus_rounded,
                                      color: currentColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            // ***
            // Product Details
            // ***
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.name,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff39393b),
                          ),
                        ),
                        Text(
                          "${widget.product.price.toInt()} VNĐ",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff39393b),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: BoxSpace.paddingDefault,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: BoxSpace.paddingDefault),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Chọn kích cỡ",
                                style: TextStyle(
                                  color: Color(0xff979797),
                                ),
                              ),
                              SizeButtonOptions(
                                color: currentColor,
                              ),
                            ],
                          ),
                        )),
                        ColorButtonOption(
                            colorList: widget.product.colors,
                            callback: handleChangeColor,
                            currentColor: currentColor)
                      ],
                    ),
                    // ***
                    // Detail Infomation
                    // ***
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mô tả chi tiết"),
                            Container(
                              width: 70,
                              child: Divider(thickness: 3, color: currentColor),
                            )
                          ],
                        ),
                      ],
                    ),
                    Text(
                      widget.product.detail,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffb2b2b2),
                      ),
                    ),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {},
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
                                Color.alphaBlend(Colors.white24, currentColor),
                                currentColor,
                              ],
                            ),
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              "Thêm vào giỏi hàng\t\t ${widget.product.price.toInt()} VNĐ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// SizeButton UI
class SizeButton extends StatelessWidget {
  final int index;
  final String title;
  final int currentIndex;
  final Function callback;
  final Color color;
  const SizeButton(
      {Key? key,
      required this.index,
      required this.title,
      required this.currentIndex,
      required this.callback,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      minWidth: 40,
      elevation: 0,
      color: index == currentIndex ? color : Color(0xffe8e8e8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: index == currentIndex ? Colors.white : Color(0xff727274),
          ),
        ),
      ),
      onPressed: () {
        callback(index);
      },
    );
  }
}

// SizeButton RenderBox
class SizeButtonOptions extends StatefulWidget {
  final Color color;
  const SizeButtonOptions({Key? key, required this.color}) : super(key: key);

  @override
  State<SizeButtonOptions> createState() => _SizeButtonOptionsState();
}

class _SizeButtonOptionsState extends State<SizeButtonOptions> {
  int currentChoice = -1;

  void handleChangeSizeButton(int index) {
    setState(() {
      currentChoice = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizeButton(
          index: 0,
          title: "S",
          currentIndex: currentChoice,
          callback: handleChangeSizeButton,
          color: widget.color,
        ),
        SizeButton(
          index: 1,
          title: "M",
          currentIndex: currentChoice,
          callback: handleChangeSizeButton,
          color: widget.color,
        ),
        SizeButton(
          index: 2,
          title: "L",
          currentIndex: currentChoice,
          callback: handleChangeSizeButton,
          color: widget.color,
        ),
        SizeButton(
          index: 3,
          title: "XL",
          currentIndex: currentChoice,
          callback: handleChangeSizeButton,
          color: widget.color,
        ),
      ],
    );
  }
}

// ColorButton RenderBox
class ColorButtonOption extends StatelessWidget {
  final List<Color> colorList;
  final Color currentColor;
  final Function callback;
  const ColorButtonOption(
      {Key? key,
      required this.colorList,
      required this.currentColor,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: colorList
          .map((color) => GestureDetector(
                onTap: () {
                  callback(color);
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: BoxSpace.paddingSmall / 2),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.alphaBlend(Colors.white30, color),
                            width: currentColor == color ? 5.0 : 0),
                        color: color,
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
