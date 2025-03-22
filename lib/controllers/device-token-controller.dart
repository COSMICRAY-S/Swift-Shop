// ignore_for_file: unnecessary_overrides

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../utils/app-constant.dart';

class GetDeviceTokenController extends GetxController {
  String? deviceToken;

  @override
  void onInit() {
    super.onInit();
    //onInit method newar karon holo jakhon google-signin theke call hobe
    // takhon autometically getDeviceToken() call hbe & devideToken fetch kore push korbe
    getDeviceToken();
  }

  Future<void> getDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();

      if (token != null) {
        deviceToken = token;
        //print("token: $deviceToken");
        update();
      }
    } catch (e) {
      Get.snackbar("error", "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSeconderyColor,
          colorText: AppConstant.appTextColor);
    }
  }
}
