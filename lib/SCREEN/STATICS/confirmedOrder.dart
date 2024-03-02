import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartlistmurchant/FUNCTION/apiCallback.dart';
import 'package:cartlistmurchant/MODAL/stockProductModal.dart';
import 'package:cartlistmurchant/PROVIDER/confirmOrderProvider.dart';
import 'package:cartlistmurchant/PROVIDER/deliverOrderProvider.dart';
import 'package:cartlistmurchant/PROVIDER/orderProductProvider.dart';
import 'package:cartlistmurchant/SCREEN/STATICS/googleMapScreen.dart';
import 'package:cartlistmurchant/SERVICE/SERVICE_DELETE/deleteConfirm.dart';
import 'package:cartlistmurchant/SERVICE/SERVICE_POST/deliverdOrder.dart';
import 'package:cartlistmurchant/SHAREPREF/cartlistSharepref.dart';
import 'package:cartlistmurchant/WIDGETS/alertDialogWidget.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistButton.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistText.dart';
import 'package:cartlistmurchant/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmedOrder extends StatefulWidget {
  final bool closed;
  final String userName;
  final String userPhone;
  final String productCount;
  final String storeId;
  final String uniqueID;
  final String orderId;
  final String address;
  final String delivery;
  final String userLat;
  final String userLong;
  const ConfirmedOrder(
      {super.key,
      required this.orderId,
      required this.address,
      required this.delivery,
      required this.userName,
      required this.userPhone,
      required this.productCount,
      required this.storeId,
      required this.uniqueID,
      required this.closed,
      required this.userLat,
      required this.userLong});

  @override
  State<ConfirmedOrder> createState() => _ConfirmedOrderState();
}

class _ConfirmedOrderState extends State<ConfirmedOrder> {
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
    var deliverOrderProvider = Provider.of<DeliverOrderProvider>(context);
    var orderProvider = Provider.of<OrderProductProvider>(context);
    var confirmOrderProvider =
        Provider.of<ConfirmOrderProvider>(context, listen: false);
    final widgetSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        orderProvider.postList.clear();
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
        body: Column(
          children: [
            Card(
              child: SizedBox(
                width: widgetSize.width,
                height: widgetSize.height / 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(widget.userName),
                            Text(
                              widget.delivery,
                              style: const TextStyle(color: colorPrimary),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.address.replaceAll(' ', '\n'),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoogleMapScreen(
                              orderLat: double.parse(widget.userLat),
                              orderlong: double.parse(widget.userLong),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: widgetSize.width / 4,
                        height: widgetSize.height / 6,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/map.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListView.builder(
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
          ],
        ),
        bottomNavigationBar: widget.closed == true
            ? SizedBox()
            : loginButton(
                context: context,
                buttonText: "Order Deliverd",
                buttonAction: () async {
                  confirmOrderProvider.postList.clear();
                  deliverOrderProvider.postList.clear();
                  final response = await addDeliverdOrder(
                    context: context,
                    userId: widget.userName,
                    storeId: widget.storeId,
                    productCount: widget.productCount,
                    userLat: '',
                    userLong: '',
                    userPhone: widget.userPhone,
                    userAddress: widget.address,
                    unqueId: widget.uniqueID,
                    delivery: widget.delivery,
                  );
                  deleteConfirmOrder(context: context, rowId: widget.orderId);
                  Future.delayed(Duration(seconds: 1), () {
                    getConfirmOrderResponse(
                        profileID: profileID.toString(), context: context);
                    getDeliverOrderResponse(
                        profileID: profileID.toString(), context: context);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      content: scafoldMessageBoxLoading(context: context),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 2.5,
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
