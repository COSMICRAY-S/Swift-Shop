// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';

import '../../controllers/cart-price-controller.dart';
import '../../models/cart-model.dart';
import '../../services/geoapify_service.dart';
import '../../utils/app-constant.dart';
import '../auth-ui/address_search.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
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
          'Checkout Screen',
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
                    color: AppConstant.appNameColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextButton(
                    child: Text(
                      "Confirm Order",
                      style: TextStyle(
                          color: AppConstant.appTextColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      ShowCustomBottomSheet();
                    },
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

void ShowCustomBottomSheet() {
  TextEditingController addressController = TextEditingController();
  RxList<String> addressSuggestions = <String>[].obs;

  void fetchAddressSuggestions(String query) async {
    if (query.length > 2) {
      // Avoid unnecessary API calls
      List<String> suggestions =
          await GeoapifyService.getPlaceSuggestions(query);
      addressSuggestions.value = suggestions;
    } else {
      addressSuggestions.clear();
    }
  }

  Get.bottomSheet(
    Container(
      height: Get.height * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: addressController,
                    onChanged: fetchAddressSuggestions,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      //contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Obx(() => addressSuggestions.isNotEmpty
                      ? Container(
                          height: 150,
                          child: ListView.builder(
                            itemCount: addressSuggestions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(addressSuggestions[index]),
                                onTap: () {
                                  addressController.text =
                                      addressSuggestions[index];
                                  addressSuggestions.clear();
                                },
                              );
                            },
                          ),
                        )
                      : SizedBox()),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstant.appNameColor,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              ),
              onPressed: () {
                Get.to(AddressSearchScreen());
              },
              child: Text(
                "Place Order",
                style: TextStyle(
                  color: AppConstant.appTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
    isDismissible: true,
    enableDrag: true,
    elevation: 6,
  );
}

// void ShowCustomBottomSheet() {
//   Get.bottomSheet(
//     Container(
//       height: Get.height * 0.8,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(16.0),
//         ),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//               child: Container(
//                 height: 50.0,
//                 child: TextFormField(
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(
//                     labelText: 'Name',
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: 10.0,
//                     ),
//                     hintStyle: TextStyle(fontSize: 12.0),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//               child: Container(
//                 height: 50.0,
//                 child: TextFormField(
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     labelText: 'Phone',
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: 10.0,
//                     ),
//                     hintStyle: TextStyle(fontSize: 12.0),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//               child: Container(
//                 height: 50.0,
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Adress',
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: 10.0,
//                     ),
//                     hintStyle: TextStyle(fontSize: 12.0),
//                   ),
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppConstant.appNameColor,
//                 padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//               ),
//               onPressed: () {},
//               child: Text(
//                 "Place Order",
//                 style: TextStyle(
//                   color: AppConstant.appTextColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     ),
//     backgroundColor: Colors.transparent,
//     isDismissible: true,
//     enableDrag: true,
//     elevation: 6,
//   );
// }
