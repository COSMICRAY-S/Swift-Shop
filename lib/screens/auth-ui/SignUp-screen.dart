// ignore_for_file: avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:swift_shop/controllers/sign-up-controller.dart';
//import 'package:lottie/lottie.dart';
import '../../utils/app-constant.dart';
import 'signin-screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //controller use korar jnno controller er instancee lagbe
  final SignUpController signUpController = Get.put(SignUpController());
  //data store korar jnno init
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userCity = TextEditingController();
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
            "Sign Up",
            style: TextStyle(color: AppConstant.appTextColor),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height / 25,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Welcome to my app",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 4, 255, 0),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
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
                        controller: userName,
                        cursorColor: AppConstant.appSeconderyColor,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: "Usar Name",
                            prefixIcon: Icon(Icons.person),
                            contentPadding:
                                EdgeInsets.only(top: 2.0, bottom: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                      ),
                    )),
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
                            contentPadding:
                                EdgeInsets.only(top: 2.0, bottom: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                      ),
                    )),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: userPhone,
                        cursorColor: AppConstant.appSeconderyColor,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "Phone",
                            prefixIcon: Icon(Icons.phone),
                            contentPadding:
                                EdgeInsets.only(top: 2.0, bottom: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                      ),
                    )),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: userCity,
                        cursorColor: AppConstant.appSeconderyColor,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                            hintText: "City",
                            prefixIcon: Icon(Icons.location_pin),
                            contentPadding:
                                EdgeInsets.only(top: 2.0, bottom: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                      ),
                    )),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Obx(
                          () => TextFormField(
                            controller: userPassword,
                            obscureText: signUpController.isPasswordVisible
                                .value, //(var isPasswordVisible = false.obs;) er value newar jnno
                            cursorColor: AppConstant.appSeconderyColor,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      signUpController.isPasswordVisible
                                          .toggle(); //toggle korle click er sathe sathe booll value change hbe
                                    },
                                    child:
                                        signUpController.isPasswordVisible.value
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility)),
                                contentPadding:
                                    EdgeInsets.only(top: 2.0, bottom: 8.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                          ),
                        ))),
                SizedBox(
                  height: Get.height / 20,
                ),
                Material(
                  child: Container(
                    width: Get.width / 2,
                    height: Get.height / 18,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 4, 255, 0),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextButton(
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                            color: AppConstant.appTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        String name = userName.text.trim();
                        String email = userEmail.text.trim();
                        String phone = userPhone.text.trim();
                        String city = userCity.text.trim();
                        String password = userPassword.text.trim();
                        String userDeviceTocken = '';

                        if (name.isEmpty ||
                            email.isEmpty ||
                            phone.isExcelFileName ||
                            city.isEmpty ||
                            password.isEmpty) {
                          Get.snackbar("Error", "Please enter all details",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appMainColor,
                              colorText: AppConstant.appTextColor);
                        } else {
                          UserCredential? userCredential =
                              await signUpController.signUpMethod(name, email,
                                  phone, city, password, userDeviceTocken);
                          if (userCredential != null) {
                            Get.snackbar("Verification email sent.",
                                "Please check your email.",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appMainColor,
                                colorText: AppConstant.appTextColor);
                            FirebaseAuth.instance.signOut();
                            Get.offAll(() => SigninScreen());
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
                      "Already have an account? ",
                      style: TextStyle(
                        color: AppConstant.appMainColor,
                        fontSize: 14.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.offAll(() => SigninScreen()),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 145, 255),
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
