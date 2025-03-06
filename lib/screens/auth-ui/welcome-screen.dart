// ignore_for_file: file_names, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:swift_shop/controllers/google_sign_in_controller.dart';
import 'package:swift_shop/screens/auth-ui/signin-screen.dart';

import '../../utils/app-constant.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final GoogleSignInController _googleSignInController =
      Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "Welcome to Swift Shop",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Lottie.asset('assets/images/cartLot.json'),
            ),
            Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Text(
                  "Happy Shopping",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: Get.height / 12,
            ),
            Material(
              child: Container(
                width: Get.width / 1.2,
                height: Get.height / 12,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 4, 255, 0),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: TextButton.icon(
                  icon: Image.asset(
                    'assets/images/final-google-logo.png',
                    width: Get.width / 12,
                    height: Get.height / 12,
                  ),
                  label: Text(
                    "Sign in with Google",
                    style: TextStyle(
                        color: AppConstant.appMainColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    _googleSignInController.signInWithGoogle();
                  },
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 35,
            ),
            Material(
              child: Container(
                width: Get.width / 1.2,
                height: Get.height / 12,
                decoration: BoxDecoration(
                  color: AppConstant.appMainColor,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: TextButton.icon(
                  icon: Icon(
                    Icons.email,
                    color: AppConstant.appTextColor,
                  ),
                  label: Text(
                    "Sign in with email",
                    style: TextStyle(
                        color: AppConstant.appTextColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Get.to(() => SigninScreen());
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
