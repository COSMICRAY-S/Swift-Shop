// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannersController extends GetxController {
  RxList<String> bannersUrls = RxList<String>([]);

  @override
  void onInit() {
    super.onInit();

    fetchBannersUrls();
  }

  //fetch banners
  Future<void> fetchBannersUrls() async {
    try {
      QuerySnapshot bannerSnapshot =
          await FirebaseFirestore.instance.collection('banners').get();

      if (bannerSnapshot.docs.isNotEmpty) {
        bannersUrls.value = bannerSnapshot.docs
            .map((doc) => doc['imageUel'] as String)
            .toList();
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
