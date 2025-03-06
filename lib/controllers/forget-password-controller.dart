// ignore_for_file: file_names, body_might_complete_normally_nullable, unused_field, unused_import, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:swift_shop/models/user_model.dart';
import 'package:swift_shop/utils/app-constant.dart';

class ForgetPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> forgetPasswordMethod(
    String userEmail,
  ) async {
    try {
      //loading dekhanor jnno
      EasyLoading.show(status: "Please wait...");

      await _auth.sendPasswordResetEmail(email: userEmail);
      Get.snackbar("error", "Password reset link sent to $userEmail",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSeconderyColor,
          colorText: AppConstant.appTextColor);

      EasyLoading.dismiss();
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Request sent succesfully", "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSeconderyColor,
          colorText: AppConstant.appTextColor);
    }
  }
}
