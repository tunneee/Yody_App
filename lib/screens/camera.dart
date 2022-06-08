import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:clothing_store_app_ui/models/constants.dart';
import 'package:clothing_store_app_ui/controls/utils.dart';
import 'package:clothing_store_app_ui/screens/home.dart';
import 'package:clothing_store_app_ui/services/storage_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import '../models/constants.dart';

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  const Camera({
    Key? key,
    required this.cameras,
  }) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController controller;
  XFile? captureFile;
  File? pictureFile;
  late CameraDescription currentCamera;
  bool isRecorded = false;

  void camSetup() {
    controller = CameraController(currentCamera, ResolutionPreset.max);
    controller.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    currentCamera = widget.cameras[0];
    camSetup();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleChangeCamera(camIndex) {
    if (camIndex == widget.cameras[0]) {
      currentCamera = widget.cameras[1];
      camSetup();
    } else {
      currentCamera = widget.cameras[0];
      camSetup();
    }
    setState(() {});
  }

  void handleTakePicture() async {
    captureFile = await controller.takePicture();
    pictureFile = File(captureFile!.path);
    setState(() {});
  }

  void handleActivateRecord() {
    if (!isRecorded) {
      handleRecordVideo();
    } else {
      handleStopVideo();
    }
    isRecorded = !isRecorded;
  }

  void handleRecordVideo() async {
    await controller.startVideoRecording();
    print('Start Recording');
  }

  // void handleStopVideo(String productID) async {
  //   XFile video = await controller.stopVideoRecording();
  //   print(098);
  //   print(video);
  //   Uint8List videoByte = await convertImageToUint8List(File(video.path));
  //   await StorageMethods()
  //       .uploadVideoToStorage('Recording_Cam', videoByte, false, productID);
  //   print(456);
  // }

  void handleStopVideo() async {
    XFile video = await controller.stopVideoRecording();
    print('Stop Recording');
    Uint8List videoByte = await convertImageToUint8List(File(video.path));
    try {
      await StorageMethods()
          .uploadVideoToStorage('Recording_Cam', videoByte, false);
      print('Upload Successul');
    } catch (e) {
      print("Something When Wrong $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ColorPalette.yodyyellow,
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                child: Container(
                  width: (height / 16) * 9,
                  height: height,
                  child: !controller.value.isInitialized
                      ? Container()
                      : CameraPreview(controller),
                )),
            Positioned(
                top: 0,
                width: width,
                child: Padding(
                  padding: EdgeInsets.all(BoxSpace.paddingSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          color: ColorPalette.yodyyellow,
                          onPressed: () {
                            if (isRecorded) {
                              handleStopVideo();
                              controller.dispose();
                            }
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            size: 30,
                          )),
                      Expanded(
                        child: SizedBox(
                            height: 35, child: Image.asset('images/logo.png')),
                      ),
                      IconButton(
                          color: ColorPalette.yodyyellow,
                          onPressed: () {
                            handleChangeCamera(currentCamera);
                          },
                          icon: Icon(
                            Icons.switch_camera_rounded,
                            size: 30,
                          ))
                    ],
                  ),
                )),
            Positioned(
                bottom: BoxSpace.paddingDefault * 2,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: BoxSpace.paddingSmall),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: ColorPalette.yodyyellow,
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                // handleActivateRecord();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builder) => Home()));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 15,
                                  ),
                                  Text(
                                    'Thêm sản phẩm',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ClothesCategories(
                      camActiveCallback: handleActivateRecord,
                    ),
                    SizedBox(
                      height: BoxSpace.paddingDefault,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: BoxSpace.paddingDefault),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    border: Border.all(
                                        color: ColorPalette.yodyyellow,
                                        width: 5)),
                                width: 65,
                                height: 65,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(60)),
                                      padding: EdgeInsets.zero,
                                      primary: Colors.white),
                                  onPressed: () {
                                    handleTakePicture();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                        color: ColorPalette.yodyyellow,
                                        borderRadius:
                                            BorderRadius.circular(60)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                              child: pictureFile != null
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ImageView(
                                                    file: pictureFile!)));
                                      },
                                      child: Image.file(
                                        pictureFile!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : null,
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: ColorPalette.darkColor,
                                  borderRadius: BorderRadius.circular(5.0))),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class ClothesCategories extends StatefulWidget {
  final Function camActiveCallback;
  const ClothesCategories({Key? key, required this.camActiveCallback})
      : super(key: key);

  @override
  State<ClothesCategories> createState() => _ClothesCategoriesState();
}

class _ClothesCategoriesState extends State<ClothesCategories> {
  // late bool isToggle;
  late int currentIndex;

  @override
  void initState() {
    currentIndex = -1;
    // isToggle = true;
    super.initState();
  }

  List<String> images = [
    '1.jpg',
    '2.jpg',
    '3.jpg',
    '4.jpg',
    '3.jpg',
    '2.jpg',
    '1.jpg',
  ];

  // void handleOpenClothesCategory(toggleState) {
  //   print(123);
  //   isToggle = !toggleState;
  //   setState(() {});
  // }

  void handleSelectClothes(index) {
    widget.camActiveCallback();
    currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Center(
        //   child: TextButton(
        //     style: TextButton.styleFrom(
        //         primary: ColorPalette.yodyyellow,
        //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0)),
        //     onPressed: () {
        //       handleOpenClothesCategory(isToggle);
        //     },
        //     child: Icon(
        //       isToggle
        //           ? Icons.arrow_drop_down_rounded
        //           : Icons.arrow_drop_up_rounded,
        //       color: ColorPalette.yodyyellow,
        //       size: 40,
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          // height: isToggle ? 120.0 : 0.0,
          height: 120.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: ((context, index) => ClothesCategoryItem(
                  callback: handleSelectClothes,
                  index: index,
                  image: images[index],
                  currentIndex: currentIndex))),
        ),
      ],
    );
  }
}

class ClothesCategoryItem extends StatelessWidget {
  final int index;
  final String image;
  final int currentIndex;
  final Function callback;
  const ClothesCategoryItem(
      {Key? key,
      required this.index,
      required this.image,
      required this.currentIndex,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback(index);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 100,
        height: 120,
        decoration: BoxDecoration(
            border: Border.all(
                color: ColorPalette.yodyyellow,
                width: currentIndex == index ? 5.0 : 0.0),
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('images/$image'))),
      ),
    );
  }
}

class ImageView extends StatelessWidget {
  final screenshotControl = ScreenshotController();
  final File file;
  ImageView({Key? key, required this.file}) : super(key: key);

  Future<bool> saveImage(Uint8List image) async {
    await [Permission.storage].request();
    String time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    String name = 'yody_$time';

    await ImageGallerySaver.saveImage(image, name: name);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                final image = await screenshotControl.capture();

                if (image == null) return;

                final state = await saveImage(image);

                if (!state) return;

                Navigator.pop(context);
              },
              icon: Icon(Icons.save_alt_rounded))
        ],
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
          child: SizedBox(
              height: height,
              child: Screenshot(
                  controller: screenshotControl, child: Image.file(file)))),
    );
  }
}
