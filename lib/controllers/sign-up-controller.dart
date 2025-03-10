// ignore_for_file: file_names, body_might_complete_normally_nullable, unused_field, unused_import, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:swift_shop/utils/app-constant.dart';

import '../models/user_model.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //for password visibility
  var isPasswordVisible = false.obs;

  Future<UserCredential?> signUpMethod(
    String userName,
    String userEmail,
    String userPhone,
    String userCity,
    String userPassword,
    String userDeviceToken,
    //push notification pathanor jnno device er tocen newa hoy
    // jate sothik device choose korte para jay
  ) async {
    try {
      //loading dekhanor jnno
      EasyLoading.show(status: "Please wait...");
      //
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      //jokhoni user toiri hobe ekhane asbe then verification hbe
      await userCredential.user!.sendEmailVerification();
      UserModel userModel = UserModel(
        uId: userCredential.user!.uid,
        username: userName,
        email: userEmail,
        phone: userPhone,
        userImg: '',
        userDeviceToken: userDeviceToken,
        country: '',
        userAddress: '',
        street: '',
        isAdmin: false,
        isActive: true,
        createdOn: DateTime.now(),
        city: userCity,
      );

      //add data into database
      _firestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());

      //try {
      //   await _firestore
      //       .collection("users")
      //       .doc(userCredential.user!.uid)
      //       .set(userModel.toMap());
      //   print("User successfully added to Firestore");
      // } catch (e) {
      //   print("Error writing to Firestore: $e");
      // }

      EasyLoading.dismiss();
      //
      return userCredential;
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        "error",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appSeconderyColor,
        colorText: AppConstant.appTextColor,
      );
    }
  }
}
