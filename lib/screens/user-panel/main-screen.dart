// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swift_shop/screens/user-panel/all-products-screen.dart';
import 'package:swift_shop/screens/user-panel/cart-screen.dart';
import 'package:swift_shop/utils/app-constant.dart';
import 'package:swift_shop/widgets/banner-widget.dart';
import 'package:get/get.dart';

import '../../widgets/all-products-widget.dart';
import '../../widgets/cateegory-widget.dart';
import '../../widgets/custom-drawer-widget.dart';
import '../../widgets/flash-sale-widget.dart';
import '../../widgets/heading-widget..dart';
import 'all-categories-screen.dart';
import 'all-flash-sale-product-screen.dart';

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
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
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
                onTAP: () => Get.to(() => AllFlashSaleScreen()),
                buttonText: "See More>>",
              ),

              FlashSaleWidgewt(),

              HeadingWidget(
                headingTitle: "All Products",
                headingSubTitle: "",
                onTAP: () => Get.to(() => AllProductsScreen()),
                buttonText: "See More>>",
              ),

              AllProductWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
