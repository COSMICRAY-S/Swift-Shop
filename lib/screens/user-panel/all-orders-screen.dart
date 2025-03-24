// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:swift_shop/models/order-model.dart';

import '../../controllers/cart-price-controller.dart';
import '../../utils/app-constant.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: Text(
          'Your Orders',
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(user!.uid)
            .collection('confirmOrders')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error, Not Found"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No Products Found!"),
            );
          }

          if (snapshot.data != null) {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  OrderModel orderModel = OrderModel(
                    productId: productData['productId'],
                    categoryId: productData['categoryId'],
                    productName: productData['productName'],
                    categoryName: productData['categoryName'],
                    salePrice: productData['salePrice'],
                    fullPrice: productData['fullPrice'],
                    productImages: productData['productImages'],
                    deliveryTime: productData['deliveryTime'],
                    isSale: productData['isSale'],
                    productDescription: productData['productDescription'],
                    createdAt: productData['createdAt'],
                    updatedAt: productData['updatedAt'],
                    productQuantity: productData['productQuantity'],
                    productTotalPrice: productData['productTotalPrice'],
                    customerId: productData['customerId'],
                    status: productData['status'],
                    customerName: productData['customerName'],
                    customerPhone: productData['customerPhone'],
                    customerAddress: productData['customerAddress'],
                    customerDeviceToken: productData['customerDeviceToken'],
                  );

                  //
                  //calculate total price
                  productPriceController.fetchProductPrice();
                  //

                  return Card(
                    elevation: 10,
                    color: AppConstant.appTextColor,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppConstant.appMainColor,

                        /***************profile er picture set korte hbe eta diye*/
                        backgroundImage: NetworkImage(
                          orderModel.productImages[0],
                        ),
                      ),
                      title: Text(orderModel.productName),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "MRP: " + orderModel.productTotalPrice.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          orderModel.status != true
                              ? Text(
                                  "Pendind...",
                                  style: TextStyle(color: Colors.green),
                                )
                              : Text(
                                  "Deliverd",
                                  style: TextStyle(color: Colors.green),
                                )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
