/*
 * UserPage
 * *
 * Feature:
 * Allow Signin, Signp
 * Display Name, Email
 * Allow Log out
 */
import 'package:clothing_store_app_ui/models/constants.dart';
import 'package:clothing_store_app_ui/services/auth_methods.dart';
import 'package:clothing_store_app_ui/screens/login_screen.dart';
import 'package:clothing_store_app_ui/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import '../controls/app.dart';
import '../widgets/option_button.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final auth = AuthMethods().getAuthInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App.bgc,
      body: SafeArea(
        child: ListView(children: [
          //
          // ***
          // User Main Cover
          // Include Avartar, Signin Signup, Name email
          // ***
          //
          Container(
            padding:
                EdgeInsets.symmetric(vertical: BoxSpace.paddingDefault * 2),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/background.png'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: BoxSpace.paddingSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //
                  // ***
                  // Avartar
                  // ***
                  //
                  Center(
                    child: CircleAvatar(
                      // backgroundImage:
                      //     auth != null ? NetworkImage('${auth?[3]}') : null,
                      backgroundColor: ColorPalette.shadeColor,
                      radius: 40,
                    ),
                  ),
                  SizedBox(
                    width: BoxSpace.paddingDefault,
                  ),
                  //
                  // ***
                  // Authenticate Button
                  // Include Signin Signup, Name email
                  // ***
                  //
                  AuthMethods().getAuthInfo() == null
                      //
                      // ***
                      // Sign in Sign up if user not Logged in
                      // ***
                      //
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: BoxSpace.paddingDefault * 2),
                              height: 40,
                              minWidth: 40,
                              elevation: 0,
                              color: App.mainc,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Center(
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(
                                    color: App.fgc,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                              },
                            ),
                            SizedBox(width: 10),
                            MaterialButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: BoxSpace.paddingDefault * 2),
                              height: 40,
                              minWidth: 40,
                              elevation: 0,
                              color: App.mdc,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Center(
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: App.fgc,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const SignupScreen()));
                              },
                            )
                          ],
                        )
                      //
                      // ***
                      // Name email if user Logged in
                      // ***
                      //
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${auth?[1] ?? auth?[2]}',
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text('${auth?[0]}'),
                          ],
                        )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),

          //
          // ***
          // Option Buttons
          // Include Wallet, Shopping Cart List, Settingm, Logout
          // ***
          //
          OptionButton(
            icon: Icons.wallet,
            label: "Wallet",
            click: () {
              //
              // ***
              // Wallet Button
              // Do something here
              // ***
              //
              AuthMethods().getAuthInfo();
            },
          ),
          OptionButton(
            icon: Icons.shopping_bag,
            label: "Your cart",
            click: () {
              //
              // ***
              // Wallet Button
              // Do something here
              // ***
              //
            },
          ),
          OptionButton(
            icon: Icons.settings,
            label: "Settings",
            click: () {
              //
              // ***
              // Wallet Button
              // Do something here
              // ***
              //
            },
          ),
          AuthMethods().getAuthInfo() != null
              ? OptionButton(
                  icon: Icons.output_outlined,
                  label: "Log out",
                  click: () async {
                    //
                    // ***
                    // Wallet Button
                    // Do something here
                    // ***
                    //
                    await AuthMethods().logOut();
                    setState(() {});
                  },
                )
              : Container()
        ]),
      ),
    );
  }
}
