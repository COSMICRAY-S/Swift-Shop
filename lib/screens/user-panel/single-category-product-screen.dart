// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:swift_shop/models/product-model.dart';
import 'package:swift_shop/utils/app-constant.dart';

import 'product-details-screen.dart';

class SingleCategoryProductsScreen extends StatefulWidget {
  String categoryId;
  SingleCategoryProductsScreen({super.key, required this.categoryId});

  @override
  State<SingleCategoryProductsScreen> createState() =>
      _SingleCategoryProductsScreenState();
}

class _SingleCategoryProductsScreenState
    extends State<SingleCategoryProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          'Products',
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('products')
            .where('categoryId', isEqualTo: widget.categoryId)
            .get(),
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
              child: Text("No category found"),
            );
          }

          if (snapshot.data != null) {
            return GridView.builder(
              //
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              //

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: 1.19),

              //
              itemBuilder: (context, index) {
                final prodactData = snapshot.data!.docs[index];
                ProductModel productModel = ProductModel(
                  productId: prodactData['productId'],
                  categoryId: prodactData['categoryId'],
                  productName: prodactData['productName'],
                  categoryName: prodactData['categoryName'],
                  salePrice: prodactData['salePrice'],
                  fullPrice: prodactData['fullPrice'],
                  productImages: prodactData['productImage'],
                  deliveryTime: prodactData['deliveryTime'],
                  isSale: prodactData['isSale'],
                  productDescription: prodactData['productDescription'],
                  createdAt: prodactData['createdAt'],
                  updatedAt: prodactData['updatedAt'],
                );
                // CategoriesModel categoriesModel = CategoriesModel(
                //   categoryId: snapshot.data!.docs[index]['categoryId'],
                //   categoryImg: snapshot.data!.docs[index]['categoryImg'],
                //   categoryName: snapshot.data!.docs[index]['categoryName'],
                //   createdAt: snapshot.data!.docs[index]['createdAt'],
                //   updatedAt: snapshot.data!.docs[index]['updatedAt'],
                // );
                return Row(
                  children: [
                    GestureDetector(
                      //
                      onTap: () => Get.to(() =>
                          ProductDetailsScreen(productModel: productModel)),
                      //
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          child: FillImageCard(
                            borderRadius: 20.0,
                            width: Get.width / 2.2,
                            heightImage: Get.height / 9,
                            imageProvider: CachedNetworkImageProvider(
                                productModel.productImages[0]),
                            title: Center(
                              child: Text(
                                productModel.productName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
