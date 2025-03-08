// ignore_for_file: file_names, avoid_unnecessary_containers

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:swift_shop/controllers/get-user-data-controller.dart';
import 'package:swift_shop/screens/admin-panel/admin-main-screen.dart';
import 'package:swift_shop/screens/auth-ui/welcome-screen.dart';
import 'package:swift_shop/screens/user-panel/main-screen.dart';
//import 'package:swift_shop/screens/user-panel/main-screen.dart';
import 'package:swift_shop/utils/app-constant.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      loggedin(context);
    });
  }

  Future<void> loggedin(BuildContext context) async {
    if (user != null) {
      final GetUserDataController getUserDataController =
          Get.put(GetUserDataController());
      var userData = await getUserDataController.getUserData(user!.uid);

      if (userData[0]['isAdmin'] == true) {
        Get.offAll(() => AdminMainScreen());
      } else {
        Get.offAll(() => MainScreen());
      }
    } else {
      Get.to(() => WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;    //er poriborte getx uuse korte pari
    return Scaffold(
      backgroundColor: AppConstant.appMainColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        elevation: 0, //jathe appbar dekha na jay
      ),
      body: Container(
        width: Get.width,
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Lottie.asset('assets/images/Shopping.json'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              width: Get.width, //size.width,
              alignment: Alignment.center,
              child: Text(
                AppConstant.appCreatedBy,
                style: TextStyle(
                    color: AppConstant.appTextColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
