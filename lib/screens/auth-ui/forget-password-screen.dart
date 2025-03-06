// ignore_for_file: avoid_unnecessary_containers, file_names

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';
//import 'package:get/get_instance/get_instance.dart';
//import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import '../../controllers/forget-password-controller.dart';
import '../../utils/app-constant.dart';
import 'SignUp-screen.dart';

class FogetPasswordScreen extends StatefulWidget {
  const FogetPasswordScreen({super.key});

  @override
  State<FogetPasswordScreen> createState() => _FogetPasswordScreenState();
}

class _FogetPasswordScreenState extends State<FogetPasswordScreen> {
  final ForgetPasswordController forgetPasswordController =
      Get.put(ForgetPasswordController());
  TextEditingController userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      //eta dara bujhabe(realtime a) je keyboard open ase ki na
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppConstant.appMainColor,
          title: Text(
            "Forget Password",
            style: TextStyle(color: AppConstant.appTextColor),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              isKeyboardVisible
                  ? Text("Welcome Back",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 0, 188, 13),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold)) //SizedBox.shrink()
                  : Column(
                      children: [
                        Lottie.asset('assets/images/comp.json'),
                      ],
                    ),
              SizedBox(
                height: Get.height / 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: userEmail,
                    cursorColor: AppConstant.appSeconderyColor,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      contentPadding: EdgeInsets.only(top: 2.0, bottom: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                alignment: Alignment.centerRight,
                child: Text(
                  "Forget Password?",
                  style: TextStyle(
                      color: AppConstant.appSeconderyColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: Get.height / 20,
              ),
              Material(
                child: Container(
                  width: Get.width / 2,
                  height: Get.height / 18,
                  decoration: BoxDecoration(
                    color: AppConstant.appMainColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextButton(
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(
                          color: AppConstant.appTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      String email = userEmail.text.trim();

                      if (email.isEmpty) {
                        Get.snackbar("Error", "Please enter all details",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appSeconderyColor,
                            colorText: AppConstant.appTextColor);
                      } else {}
                    },
                  ),
                ),
              ),
              SizedBox(
                height: Get.height / 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dont have an account? ",
                    style: TextStyle(
                      color: AppConstant.appSeconderyColor,
                      fontSize: 14.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.offAll(() => SignUpScreen()),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 0, 188, 13),
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
