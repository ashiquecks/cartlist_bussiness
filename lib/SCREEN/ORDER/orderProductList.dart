import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartlistmurchant/FUNCTION/apiCallback.dart';
import 'package:cartlistmurchant/MODAL/stockProductModal.dart';
import 'package:cartlistmurchant/PROVIDER/confirmOrderProvider.dart';
import 'package:cartlistmurchant/PROVIDER/orderProductProvider.dart';
import 'package:cartlistmurchant/PROVIDER/orderProvider.dart';
import 'package:cartlistmurchant/SERVICE/SERVICE_DELETE/deleteOrder.dart';
import 'package:cartlistmurchant/SERVICE/SERVICE_POST/confirmOrder.dart';
import 'package:cartlistmurchant/SERVICE/SERVICE_UPDATE/orderProductUpdate.dart';
import 'package:cartlistmurchant/SHAREPREF/cartlistSharepref.dart';
import 'package:cartlistmurchant/WIDGETS/alertDialogWidget.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistButton.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistText.dart';
import 'package:cartlistmurchant/const.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class OrderProductList extends StatefulWidget {
  final String distance;
  final String purchaseDate;
  final String delivery;
  final String orderId;
  final String userName;
  final String phoneNumber;
  final String houseName;
  final String landMark;
  final String place;
  final String pinCode;
  final String city;
  final String userlat;
  final String userLong;
  final String uniqueID;
  final String itemCount;
  const OrderProductList({
    super.key,
    required this.userName,
    required this.phoneNumber,
    required this.houseName,
    required this.landMark,
    required this.place,
    required this.pinCode,
    required this.city,
    required this.userlat,
    required this.userLong,
    required this.delivery,
    required this.orderId,
    required this.distance,
    required this.purchaseDate,
    required this.uniqueID,
    required this.itemCount,
  });

  @override
  State<OrderProductList> createState() => _OrderProductListState();
}

class _OrderProductListState extends State<OrderProductList> {
  String? profileID;

  void getSharePrefData() {
    setState(() {
      profileID = preferences!.getString("ShopID");
    });
  }

  @override
  void initState() {
    super.initState();
    getSharePrefData();
  }

  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<OrderProductProvider>(context);
    var order = Provider.of<OrderProvider>(context);
    final widgetSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        orderProvider.postList.clear();
        Navigator.pushNamed(context, '/homeNavigation');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          leadingWidth: 0,
          backgroundColor: colorWhite,
          title: Text(
            "Order Id: ${widget.orderId}",
            style: const TextStyle(color: colorPrimary),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.cloud_circle))
          ],
        ),
        body: ListView.builder(
            itemCount: orderProvider.postList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              StockProductModal modalResponse =
                  orderProvider.getPostByIndex(index);
              return Row(
                children: [
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl: modalResponse.productImage,
                        width: 100,
                        placeholder: (context, url) => Image.asset(
                          'assets/images/placeholder.jpg',
                          width: 100,
                          height: 100,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: widgetSize.width / 1.6,
                    child: ListTile(
                      title: Text(modalResponse.productName),
                      subtitle: Text(modalResponse.productBrand),
                    ),
                  ),
                ],
              );
            }),
        bottomNavigationBar: Builder(
          builder: (BuildContext context) {
            return loginButton(
              context: context,
              buttonText: "Confirm Order",
              buttonAction: () {
                showModalBottomSheet(
                  context: context,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.all(15),
                      width: widgetSize.width,
                      height: widgetSize.height / 2.5,
                      child: Column(
                        children: [
                          Container(
                            width: widgetSize.width,
                            height: 50,
                            color: colorPrimaryLight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  child: normalTextWithPaddingColor(
                                      labelText: "${widget.itemCount} Products",
                                      textCilor: colorWhite),
                                ),
                                normalTextWithPadding(
                                    labelText: widget.delivery),
                                cartlistWidgettext(
                                  widgetColor: colorBlack,
                                  textIcon: Icons.location_pin,
                                  labeltext: widget.distance,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              normalTextWithPadding(labelText: widget.userName),
                              normalTextWithPadding(
                                  labelText: widget.phoneNumber),
                              normalTextWithPadding(
                                  labelText: widget.houseName),
                              normalTextWithPadding(labelText: widget.landMark),
                              normalTextWithPadding(labelText: widget.place),
                              Row(
                                children: [
                                  normalTextWithPadding(
                                      labelText: widget.pinCode),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  normalTextWithPadding(labelText: widget.city),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colorPrimary),
                              onPressed: () async {
                                order.postList.clear();
                                confirmedOrder();
                                Navigator.of(context).pop(true);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    content: scafoldMessageBox(
                                        context: context,
                                        message: "Order Confirmed"),
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.only(
                                      bottom: widgetSize.height / 2.5,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "Confirm This Order",
                                style: TextStyle(color: colorWhite),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  confirmedOrder() async {
    var confirmOrderProvider =
        Provider.of<ConfirmOrderProvider>(context, listen: false);
    var orderProvider =
        Provider.of<OrderProductProvider>(context, listen: false);
    final response = await addConfirmOrder(
      context: context,
      userId: widget.userName,
      storeId: profileID.toString(),
      productCount: widget.itemCount,
      userLat: widget.userlat,
      userLong: widget.userLong,
      userPhone: widget.phoneNumber,
      userAddress: widget.houseName +
          widget.landMark +
          widget.place +
          widget.pinCode +
          widget.city,
      unqueId: widget.uniqueID,
      distance: widget.distance,
      delivery: widget.delivery,
      confirmid: widget.orderId,
    );

    deleteOrder(context: context, orderId: widget.orderId);

    confirmOrderProvider.postList.clear();

    Future.delayed(Duration(seconds: 1), () {
      getOrderResponse(profileID: profileID.toString(), context: context);
      getConfirmOrderResponse(
          profileID: profileID.toString(), context: context);
    });
  }
}
