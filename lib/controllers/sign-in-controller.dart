// ignore_for_file: file_names, body_might_complete_normally_nullable, unused_field, unused_import, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../utils/app-constant.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //for password visibility
  var isPasswordVisible = false.obs;

  Future<UserCredential?> signInMethod(
    String userEmail,
    String userPassword,
  ) async {
    try {
      //loading dekhanor jnno
      EasyLoading.show(status: "Please wait...");
      //
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      ); //

      EasyLoading.dismiss();
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
