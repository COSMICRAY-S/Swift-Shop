// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swift_shop/utils/app-constant.dart';
import 'package:swift_shop/widgets/banner-widget.dart';
import 'package:swift_shop/widgets/custom-drawer-widget.dart';
import 'package:get/get.dart';

import '../../widgets/heading-widget..dart';

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
              Text("🥰🥰🥰"),
              //banner
              BannerWidget(),

              //
              HeadingWidget(
                headingTitle: "Categories",
                headingSubTitle: "According to your budget",
                onTAP: () {},
                buttonText: "See More>>",
              ),

              HeadingWidget(
                headingTitle: "Flash sale",
                headingSubTitle: "",
                onTAP: () {},
                buttonText: "See More>>",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
