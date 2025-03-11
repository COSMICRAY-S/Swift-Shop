// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../controllers/cart-price-controller.dart';
import '../../models/cart-model.dart';
import '../../utils/app-constant.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
          'Cart Screen',
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(user!.uid)
            .collection('cartOrders')
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
                  CartModel cartModel = CartModel(
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
                  );

                  //
                  //calculate total price
                  productPriceController.fetchProductPrice();
                  //

                  return SwipeActionCell(
                    key: ObjectKey(cartModel.productId),
                    trailingActions: [
                      SwipeAction(
                        title: "Delete",
                        forceAlignmentToBoundary: true,
                        performsFirstActionWithFullSwipe:
                            true, //puro slide tene rakhar jnno
                        onTap: (CompletionHandler handler) async {
                          print('deleted');

                          await FirebaseFirestore.instance
                              .collection('cart')
                              .doc(user!.uid)
                              .collection('cartOrders')
                              .doc(cartModel.productId)
                              .delete();
                        },
                      )
                    ],
                    child: Card(
                      elevation: 10,
                      color: AppConstant.appTextColor,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppConstant.appMainColor,

                          /***************profile er picture set korte hbe eta diye*/
                          backgroundImage: NetworkImage(
                            cartModel.productImages[0],
                          ),
                        ),
                        title: Text(cartModel.productName),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "MRP: " + cartModel.productTotalPrice.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: Get.width / 5,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (cartModel.productQuantity > 1) {
                                  await FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc(user!.uid)
                                      .collection('cartOrders')
                                      .doc(cartModel.productId)
                                      .update(
                                    {
                                      'productQuantity':
                                          cartModel.productQuantity - 1,
                                      'productTotalPrice':
                                          cartModel.productTotalPrice -
                                              double.parse(cartModel.isSale
                                                  ? cartModel.salePrice
                                                  : cartModel.fullPrice),
                                    },
                                  );
                                }
                              },
                              child: CircleAvatar(
                                radius: 14.0,
                                backgroundColor: AppConstant.appNameColor,
                                child: Text("-"),
                              ),
                            ),
                            // SizedBox(
                            //   width: Get.width / 20,
                            // ),
                            Text(
                              " Unit:" + cartModel.productQuantity.toString(),
                              style: TextStyle(color: AppConstant.appMainColor),
                            ),
                            // SizedBox(
                            //   width: Get.width / 20,
                            // ),
                            GestureDetector(
                              onTap: () async {
                                if (cartModel.productQuantity > 0) {
                                  await FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc(user!.uid)
                                      .collection('cartOrders')
                                      .doc(cartModel.productId)
                                      .update(
                                    {
                                      'productQuantity':
                                          cartModel.productQuantity + 1,
                                      'productTotalPrice':
                                          cartModel.productTotalPrice +
                                              double.parse(cartModel.isSale
                                                  ? cartModel.salePrice
                                                  : cartModel.fullPrice),
                                    },
                                  );
                                }
                              },
                              child: CircleAvatar(
                                radius: 14.0,
                                backgroundColor: AppConstant.appNameColor,
                                child: Text("+"),
                              ),
                            ),
                          ],
                        ),
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
      bottomNavigationBar: Container(
        color: AppConstant.appTextColor,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Obx newar karon , realtime a calculation
            Obx(
              () => Text(
                " Total: ${productPriceController.totalPrice.value.toStringAsFixed(1)} MRP",
                style: TextStyle(
                  color: AppConstant.appNameColor,
                  fontWeight: FontWeight.bold,
                ),
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
