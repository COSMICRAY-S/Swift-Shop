// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:swift_shop/utils/app-constant.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: Text(
          'Cart Screen',
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 20,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
              elevation: 10,
              color: AppConstant.appTextColor,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppConstant.appMainColor,
                  child: Text(
                    "N",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                ),
                title: Text('New Dress'),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '2000',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: Get.width / 20,
                    ),
                    CircleAvatar(
                      radius: 14.0,
                      backgroundColor: AppConstant.appNameColor,
                      child: Text("-"),
                    ),
                    SizedBox(
                      width: Get.width / 20,
                    ),
                    CircleAvatar(
                      radius: 14.0,
                      backgroundColor: AppConstant.appNameColor,
                      child: Text("+"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total"),
            // SizedBox(
            //   width: Get.width / 20,
            // ),
            Text(
              "MRP: 1200.00",
              style: TextStyle(
                color: AppConstant.appNameColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: Get.width / 20,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Material(
                child: Container(
                  width: Get.width / 3,
                  height: Get.height / 20,
                  decoration: BoxDecoration(
                    color: AppConstant.appMainColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextButton(
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                          color: AppConstant.appTextColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
