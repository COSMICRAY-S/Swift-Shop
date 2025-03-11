// ignore_for_file: avoid_unnecessary_containers, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/get-user-data-controller.dart';
import '../../controllers/sign-in-controller.dart';
import '../../utils/app-constant.dart';
import '../admin-panel/admin-main-screen.dart';
import '../user-panel/main-screen.dart';
import 'SignUp-screen.dart';
import 'forget-password-screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      //eta dara bujhabe(realtime a) je keyboard open ase ki na
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppConstant.appMainColor,
          title: Text(
            "Sign in",
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
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Obx(
                    () => TextFormField(
                      controller: userPassword,
                      obscureText: signInController.isPasswordVisible.value,
                      cursorColor: AppConstant.appSeconderyColor,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            signInController.isPasswordVisible.toggle();
                          },
                          child: signInController.isPasswordVisible.value
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                        contentPadding: EdgeInsets.only(top: 2.0, bottom: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => FogetPasswordScreen());
                  },
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(
                        color: AppConstant.appSeconderyColor,
                        fontWeight: FontWeight.bold),
                  ),
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
                      String password = userPassword.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please enter all details",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appSeconderyColor,
                          colorText: AppConstant.appTextColor,
                        );
                      } else {
                        UserCredential? userCredential = await signInController
                            .signInMethod(email, password);

                        var userData = await getUserDataController
                            .getUserData(userCredential!.user!.uid);

                        if (userCredential != null) {
                          if (userCredential.user!.emailVerified) {
                            Get.offAll(() => MainScreen());

                            if (userData[0]['isAdmin'] == true) {
                              //
                              Get.snackbar(
                                "Succes Admin Login",
                                "Welcome to admin panel.",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSeconderyColor,
                                colorText: AppConstant.appTextColor,
                              );
                              //jodi admin hoy

                              Get.offAll(() => AdminMainScreen());
                            } else {
                              //jodi admin na hhoy tahole user panel a chole asbe
                              Get.offAll(() => MainScreen());
                              Get.snackbar(
                                  "Success User Login", "Login Successfully.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor:
                                      AppConstant.appSeconderyColor,
                                  colorText: AppConstant.appTextColor);
                            }
                          } else {
                            Get.snackbar(
                              "Error",
                              "Please verify your email before login.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSeconderyColor,
                              colorText: AppConstant.appTextColor,
                            );
                          }
                        } else {
                          Get.snackbar(
                            "Error",
                            "Please try again.",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appSeconderyColor,
                            colorText: AppConstant.appTextColor,
                          );
                        }
                      }
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
