// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, avoid_print, deprecated_member_use, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:swift_shop/controllers/rating_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/cart-model.dart';
import '../../models/product-model.dart';
import '../../models/review_model.dart';
import '../../utils/app-constant.dart';
import 'cart-screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
  ProductDetailsScreen({super.key, required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    CalculateProductRatingController calculateProductRatingController = Get.put(
        CalculateProductRatingController(widget.productModel.productId));
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "Product Details",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
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

                    //avg reviews show
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: RatingBar.builder(
                            glow: false,
                            ignoreGestures: true,
                            initialRating: double.parse(
                                calculateProductRatingController.averageRating
                                    .toString()),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (value) {},
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          calculateProductRatingController.averageRating
                              .toString(),
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
                                  "Whats App",
                                  style: TextStyle(
                                      color: AppConstant.appTextColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  sendMessageOnWhatsApp(
                                    productModel: widget.productModel,
                                  );
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
                                onPressed: () async {
                                  await checkProductExistance(uId: user!.uid);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //reviews
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('products')
                  .doc(widget.productModel.productId)
                  .collection('reviews')
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: Get.height / 6,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  );
                }

                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text("No reviews found!"),
                  );
                }

                if (snapshot.data != null) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      ReviewModel reviewModel = ReviewModel(
                        customerName: data['customerName'],
                        customerPhone: data['customerPhone'],
                        customerDeviceToken: data['customerDeviceToken'],
                        customerId: data['customerId'],
                        feedback: data['feedback'],
                        rating: data['rating'],
                        createdAt: data['createdAt'],
                      );
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            reviewModel.customerName[0],
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        title: Text(
                          reviewModel.customerName,
                          style: TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(reviewModel.feedback),
                        trailing: Text(reviewModel.rating),
                      );
                    },
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  //sending message on whatsApp

  static Future<void> sendMessageOnWhatsApp({
    required ProductModel productModel,
  }) async {
    final String number = "+8801613022629";
    final String message =
        "Hello COSMICRAY \nI want to know about this product \n${productModel.productName} \n${productModel.productId}";

    final Uri url =
        Uri.parse("https://wa.me/$number?text=${Uri.encodeComponent(message)}");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch ~~~~~~~~~~~~~~~~~~~~~~~~$url';
    }
  }
  // static Future<void> sendMessageOnWhatsApp({
  //   required ProductModel productModel,
  // }) async {
  //   final number = "+8801613022629";
  //   final message =
  //       "hello COSMICRAY \n I want to know about this product \n ${productModel.productName} \n ${productModel.productId}";
  //   final url = 'https://wa.me/$number?text=${Uri.encodeComponent(message)}';

  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch ~~~~~~~~~~~~~~~~~~~$url';
  //   }
  // }

  // chech product exist or not
  Future<void> checkProductExistance({
    required String uId,
    int quantityIncrement = 1,
  }) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrders')
        .doc(widget.productModel.productId.toString());

    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      int currentQuantity = snapshot['productQuantity'];
      int updatedQuantity = currentQuantity + quantityIncrement;
      double totalPrice = double.parse(widget.productModel.isSale
              ? widget.productModel.salePrice
              : widget.productModel.fullPrice) *
          updatedQuantity;

      await documentReference.update(
        {
          'productQuantity': updatedQuantity,
          'productTotalPrice': totalPrice,
        },
      );
      print("product exist");
    } else {
      await FirebaseFirestore.instance.collection('cart').doc(uId).set(
        {
          'uId': uId,
          'createdAt': DateTime.now(),
        },
      );
      CartModel cartModel = CartModel(
        productId: widget.productModel.productId,
        categoryId: widget.productModel.categoryId,
        productName: widget.productModel.productName,
        categoryName: widget.productModel.categoryName,
        salePrice: widget.productModel.salePrice,
        fullPrice: widget.productModel.fullPrice,
        productImages: widget.productModel.productImages,
        deliveryTime: widget.productModel.deliveryTime,
        isSale: widget.productModel.isSale,
        productDescription: widget.productModel.productDescription,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        productQuantity: 1,
        productTotalPrice: widget.productModel.isSale == true
            ? double.parse(widget.productModel.salePrice)
            : double.parse(widget.productModel.fullPrice),
      );

      await documentReference.set(cartModel.toMap());
      print("product Added");
    }
  }
}
