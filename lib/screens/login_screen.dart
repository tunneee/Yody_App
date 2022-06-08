/*
 * Login Screen
 * *
 * Feature:
 * Input Email, Password 
 */
import 'package:clothing_store_app_ui/models/constants.dart';
import 'package:clothing_store_app_ui/main_page.dart';
import 'package:flutter/material.dart';
import 'package:clothing_store_app_ui/services/auth_methods.dart';
import 'package:clothing_store_app_ui/screens/signup_screen.dart';
import 'package:clothing_store_app_ui/controls/utils.dart';
import 'package:clothing_store_app_ui/widgets/text_field_input.dart';
import '../controls/app.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //
  // ***
  // Login variables
  // Include email control, password control, isLoading state
  // ***
  //
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  //
  // ***
  // Handle Login User
  // ***
  //
  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "success") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPage()));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  //
  // ***
  // Handle Navigate to SignUp
  // ***
  //
  void navigateToSignup() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  //
  // ***
  // Handle Navigate to MainPage
  // ***
  //
  void navigateToMainPage() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
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
                          //
                          // ***
                          // Pop up Button
                          // Do something here
                          // ***
                          //
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
                    SizedBox(
                      height: 50,
                    ),
                    //
                    // ***
                    // Logo Image
                    // ***
                    //
                    Image.asset('assets/logo-yody.png',
                        color: App.sbgc == Colors.black ? App.fgc : null,
                        height: 100),
                    const SizedBox(height: 64),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: BoxSpace.paddingDefault,
                          vertical: BoxSpace.paddingSmall),
                      child: InkWell(
                        onTap: () {
                          //
                          // ***
                          // Sign in Button
                          // Do something here
                          // ***
                          //
                          loginUser();
                        },
                        child: Container(
                          height: BoxSpace.paddingDefault * 3,
                          child: _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
                                )
                              : const Text(
                                  'Log in',
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
                    const Text(
                      "Don't have an acount?",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        //
                        // ***
                        // Navigate Button
                        // Do something here
                        // ***
                        //
                        navigateToSignup();
                      },
                      child: Container(
                        child: const Text("Sign up.",
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
