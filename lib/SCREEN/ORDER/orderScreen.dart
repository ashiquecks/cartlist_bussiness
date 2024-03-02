import 'package:cartlistmurchant/FUNCTION/apiCallback.dart';
import 'package:cartlistmurchant/MODAL/orderModal.dart';
import 'package:cartlistmurchant/PROVIDER/orderProductProvider.dart';
import 'package:cartlistmurchant/PROVIDER/orderProvider.dart';
import 'package:cartlistmurchant/SCREEN/ORDER/orderProductList.dart';
import 'package:cartlistmurchant/SERVICE/SERVICE_GET/getOrderProduct.dart';
import 'package:cartlistmurchant/SHAREPREF/cartlistSharepref.dart';
import 'package:cartlistmurchant/WIDGETS/alertDialogWidget.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistButton.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistText.dart';
import 'package:cartlistmurchant/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  getOrderProductResponse({required String uniqID}) async {
    var provider = Provider.of<OrderProductProvider>(context, listen: false);
    var response =
        await getStockByUniqueResponse(context: context, uniqueID: uniqID);

    if (response.isSuccessful!) {
      provider.setPostList(response.data!);
    } else if (response.message ==
        "Unable to reach the internet! Ple ase try again in  a minutes or two") {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/lossConnection');
    } else {}
  }

  String? profileID;

  void getSharePref() {
    setState(() {
      profileID = preferences!.getString("ShopID");
    });
  }

  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<OrderProvider>(
      context,
    );
    final widgetSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorWhite,
        leading: const SizedBox(),
        leadingWidth: 0,
        title: const Text(
          "Order",
          style: TextStyle(color: colorPrimary),
        ),
      ),
      body: ListView.builder(
        itemCount: orderProvider.postList.length,
        itemBuilder: (context, index) {
          OrderModal modalResponse = orderProvider.getPostByIndex(index);
          return InkWell(
            onTap: () async {
              getOrderProductResponse(uniqID: modalResponse.uniqueId);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderProductList(
                    city: modalResponse.city,
                    delivery: modalResponse.delivery,
                    houseName: modalResponse.userHouse,
                    landMark: modalResponse.landmark,
                    phoneNumber: modalResponse.userPhone,
                    pinCode: modalResponse.pinCode,
                    place: modalResponse.place,
                    userLong: modalResponse.userLong,
                    userName: modalResponse.userId,
                    userlat: modalResponse.userLat,
                    orderId: modalResponse.orderId,
                    distance: modalResponse.distance,
                    purchaseDate: modalResponse.purchaseDate,
                    uniqueID: modalResponse.uniqueId,
                    itemCount: modalResponse.productCount,
                  ),
                ),
              );
            },
            child: Card(
              color: colorPrimaryLight,
              child: Row(
                children: [
                  Container(
                    width: widgetSize.width / 2.5,
                    height: widgetSize.height / 4,
                    color: colorWhite,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          modalResponse.delivery == "Home Delivery"
                              ? "assets/images/delevery.png"
                              : "assets/images/store_pickup.png",
                          width: 100,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(border: Border.all()),
                          child: normalTextWithPaddingSize(
                              labelText:
                                  "${modalResponse.productCount} Products",
                              textCilor: colorBlack),
                        ),
                        normalTextWithPaddingColor(
                          labelText: modalResponse.purchaseDate,
                          textCilor: colorBlack,
                        ),
                        normalTextWithPadding(
                            labelText: modalResponse.delivery),
                        cartlistWidgettext(
                          widgetColor: colorBlack,
                          textIcon: Icons.location_pin,
                          labeltext: modalResponse.distance,
                        ),
                      ],
                    ),
                  ),
                  //SECOND SECTION
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      normalTextWithPaddingColor(
                          labelText: modalResponse.userId,
                          textCilor: colorWhite),
                      normalTextWithPaddingColor(
                          labelText: modalResponse.userPhone,
                          textCilor: colorWhite),
                      normalTextWithPaddingColor(
                          labelText: modalResponse.userHouse,
                          textCilor: colorWhite),
                      normalTextWithPaddingColor(
                          labelText: modalResponse.place,
                          textCilor: colorWhite),
                      normalTextWithPaddingColor(
                          labelText: modalResponse.pinCode,
                          textCilor: colorWhite),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.refresh,
          color: colorWhite,
        ),
        onPressed: () {
          orderProvider.postList.clear();
          reloadOrder(context: context, profileID: profileID.toString());
        },
      ),
    );
  }

  reloadOrder({required BuildContext context, required String profileID}) {
    getOrderResponse(
      context: context,
      profileID: profileID.toString(),
    );
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
  }
}


// return Card(
//             elevation: 12,
//             margin: const EdgeInsets.all(10),
//             child: SizedBox(
//               width: widgetSize.width,
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   ListTile(
//                     leading: textIocnButtonBlack(
//                         buttonText: modalResponse.purchaseDate.toString(),
//                         buttonIcon: Icons.calendar_month_rounded),
//                     trailing: textIocnButtonBlack(
//                         buttonText: "03:10 AM", buttonIcon: Icons.more_time),
//                   ),
//                   Row(
//                     children: [
//                       const SizedBox(width: 15),
//                       textIocnButtonBlack(
//                           buttonText: modalResponse.productCount,
//                           buttonIcon: Icons.shopping_basket),
//                       TextButton.icon(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.location_pin,
//                           size: 15,
//                         ),
//                         label: const Text(
//                           "3 min",
//                         ),
//                       ),
//                       textIocnButtonRed(
//                         buttonText: modalResponse.delivery,
//                         buttonIcon: Icons.store,
//                       )
//                     ],
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(10),
//                     width: widgetSize.width,
//                     height: 40,
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: const Text("view order"),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );