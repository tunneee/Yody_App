/*
 * Register Page
 * *
 * Feature:
 * Input name, email, password, Image, bio
 */
import 'dart:typed_data';
import 'package:clothing_store_app_ui/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clothing_store_app_ui/services/auth_methods.dart';
import 'package:clothing_store_app_ui/screens/login_screen.dart';
import 'package:clothing_store_app_ui/controls/utils.dart';
import 'package:clothing_store_app_ui/widgets/text_field_input.dart';

import '../controls/app.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  //
  // ***
  // Register Variables
  // Include email control, password control, bio control, name control, Image control, isLoading state
  // ***
  //
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  //
  // ***
  // Handle Select Image
  // ***
  //
  void selectImage(String option) async {
    late Uint8List? im;
    if (option == 'camera') {
      im = await pickImage(ImageSource.camera);
    } else if (option == 'gallery') {
      im = await pickImage(ImageSource.gallery);
    }
    if (im == null) return;
    Navigator.of(context).pop();
    setState(() {
      _image = im;
    });
  }

  //
  // ***
  // Handle SignUp User
  // ***
  //
  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    print(res);
    if (res != 'success') {
      showSnackBar(res, context);
      navigateToMainPage();
    }
  }

  //
  // ***
  // Navigate to Login
  // ***
  //
  void navigateToLogin() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  //
  // ***
  // Navigate to MainPage
  // ***
  //
  void navigateToMainPage() {
    Navigator.of(context).pop();
  }

  //
  // ***
  // Open Option Dialog
  // ***
  //
  void openOption() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Select option'),
            content: SizedBox(
              height: 120,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 60,
                      child: TextButton(
                        style: TextButton.styleFrom(primary: Colors.black),
                        onPressed: () {
                          selectImage('camera');
                        },
                        child: Row(
                          children: [
                            Icon(Icons.camera),
                            SizedBox(width: 15),
                            Text('With camera', textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      child: TextButton(
                        style: TextButton.styleFrom(primary: Colors.black),
                        onPressed: () {
                          selectImage('gallery');
                        },
                        child: Row(
                          children: [
                            Icon(Icons.image),
                            SizedBox(width: 15),
                            Text('On gallery', textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                    )
                  ]),
            ),
          ));

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Object? data = ModalRoute.of(context)?.settings.arguments;
    print(data);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(BoxSpace.paddingDefault / 2),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          navigateToMainPage();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: ColorPalette.yodyyellow,
                        ))
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height: 40),

                    Flexible(child: Container(), flex: 2),
                    //
                    // ***
                    // Logo Image
                    // ***
                    //
                    Image.asset('assets/logo-yody.png',
                        color: App.sbgc == Colors.black ? App.fgc : null,
                        height: 100),

                    const SizedBox(height: 40),
                    //
                    // ***
                    // Avater Picker
                    // ***
                    //
                    Center(
                      child: Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(_image!),
                                )
                              : const CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                      'https://yt3.ggpht.com/f8oN5FjG0GbWYgFbjcK6oljSXuNCZo43yvb-HIuDGQNzENX_n5TLfsVrp-ULMEHolCppuKg0=s900-c-k-c0x00ffffff-no-rj')),
                          Positioned(
                            bottom: 0,
                            left: 80,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100)),
                              child: IconButton(
                                onPressed: openOption,
                                icon: Icon(
                                  Icons.add_a_photo,
                                  color: ColorPalette.yodyyellow,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: BoxSpace.paddingDefault),
                      child: Text("* Avatar image is required for register!",
                          style: TextStyle(color: Colors.red)),
                    ),
                    //
                    // ***
                    // Text input for Username
                    // ***
                    //
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: BoxSpace.paddingDefault,
                          vertical: BoxSpace.paddingSmall / 2),
                      child: TextFieldInput(
                          hintText: 'Enter your username',
                          textEditingController: _usernameController,
                          textInputType: TextInputType.text),
                    ),
                    //
                    // ***
                    // Text input for email
                    // ***
                    //
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: BoxSpace.paddingDefault,
                          vertical: BoxSpace.paddingSmall / 2),
                      child: TextFieldInput(
                          hintText: 'Enter your email',
                          textEditingController: _emailController,
                          textInputType: TextInputType.emailAddress),
                    ),
                    //
                    // ***
                    // Text input for Password
                    // ***
                    //
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: BoxSpace.paddingDefault,
                          vertical: BoxSpace.paddingSmall / 2),
                      child: TextFieldInput(
                        hintText: 'Enter your password',
                        textEditingController: _passwordController,
                        textInputType: TextInputType.text,
                        isPass: true,
                      ),
                    ),
                    //
                    // ***
                    // Text input for Bio
                    // ***
                    //
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: BoxSpace.paddingDefault,
                          vertical: BoxSpace.paddingSmall / 2),
                      child: TextFieldInput(
                          hintText: 'Enter your bio',
                          textEditingController: _bioController,
                          textInputType: TextInputType.text),
                    ),
                    //
                    // ***
                    // Sign p Button
                    // ***
                    //
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: BoxSpace.paddingDefault,
                          vertical: BoxSpace.paddingSmall / 2),
                      child: InkWell(
                        onTap: signUpUser,
                        child: Container(
                          height: BoxSpace.paddingDefault * 3,
                          child: _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
                                )
                              : const Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              color: ColorPalette.yodyyellow),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Flexible(child: Container(), flex: 2),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(BoxSpace.paddingDefault),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text(
                        "Already have an acoount?",
                        style: TextStyle(fontSize: 15),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: navigateToLogin,
                      child: Container(
                        child: const Text("Login.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
