// ignore_for_file: must_be_immutable, avoid_unnecessary_containers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_shop/models/product-model.dart';
import 'package:swift_shop/utils/app-constant.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
  ProductDetailsScreen({super.key, required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "Product Details",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            //products images
            SizedBox(
              height: Get.height / 80, //image er uopre gapp rakhar jnno
            ),
            CarouselSlider(
              items: widget.productModel.productImages
                  .map(
                    (imageUrls) => ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: imageUrls,
                        fit: BoxFit.cover,
                        width: Get.width - 15, //side diye gap rakhar jnno
                        placeholder: (context, url) => ColoredBox(
                          color: Colors.white,
                          child: Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                aspectRatio: 1.5,
                viewportFraction: 1,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.productModel.productName,
                              style: TextStyle(
                                color: AppConstant.appNameColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.favorite_outline)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            widget.productModel.isSale == true &&
                                    widget.productModel.salePrice != ''
                                ? Text(
                                    "MRP: ${widget.productModel.salePrice}",
                                  )
                                : Text(
                                    "MRP: ${widget.productModel.fullPrice}",
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Category: ${widget.productModel.categoryName}",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "🛍🛍 ${widget.productModel.productDescription}",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              child: Container(
                                width: Get.width / 3,
                                height: Get.height / 18,
                                decoration: BoxDecoration(
                                  color: AppConstant.appMainColor,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: TextButton(
                                  child: Text(
                                    "Buy now",
                                    style: TextStyle(
                                        color: AppConstant.appTextColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    //Get.to(() => SigninScreen());
                                  },
                                ),
                              ),
                            ),

                            //
                            SizedBox(
                              width: Get.width / 30,
                            ),
                            Material(
                              child: Container(
                                width: Get.width / 3,
                                height: Get.height / 18,
                                decoration: BoxDecoration(
                                  color: AppConstant.appMainColor,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: TextButton(
                                  child: Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                        color: AppConstant.appTextColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    //Get.to(() => SigninScreen());
                                  },
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
