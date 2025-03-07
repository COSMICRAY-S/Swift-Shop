// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swift_shop/utils/app-constant.dart';
import 'package:swift_shop/widgets/banner-widget.dart';
import 'package:get/get.dart';

import '../../widgets/cateegory-widget.dart';
import '../../widgets/custom-drawer-widget.dart';
import '../../widgets/flash-sale-widget.dart';
import '../../widgets/heading-widget..dart';
import 'all-categories-screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppConstant.appTextColor,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppConstant.appMainColor,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          AppConstant.appMainName,
          style: TextStyle(
            color: AppConstant.appTextColor,
          ),
        ),
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 90.0,
              ),
              Text("💥Darun Offer🔥"),
              SizedBox(
                height: Get.height / 100,
              ),
              //banner
              BannerWidget(),
              //
              HeadingWidget(
                headingTitle: "Categories",
                headingSubTitle: "According to your budget",
                onTAP: () => Get.to(() => AllCategoriesScreen()),
                buttonText: "See More>>",
              ),

              CategoriesWidget(),

              HeadingWidget(
                headingTitle: "Flash sale",
                headingSubTitle: "Discount up to 75%",
                onTAP: () {},
                buttonText: "See More>>",
              ),

              FlashSaleWidgewt(),
            ],
          ),
        ),
      ),
    );
  }
}
