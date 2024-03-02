import 'package:cartlistmurchant/FUNCTION/apiCallback.dart';
import 'package:cartlistmurchant/MODAL/deliverOrderModal.dart';
import 'package:cartlistmurchant/PROVIDER/deliverOrderProvider.dart';
import 'package:cartlistmurchant/SCREEN/STATICS/confirmedOrder.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistCard.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistText.dart';
import 'package:cartlistmurchant/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class DeliverdOrder extends StatefulWidget {
  const DeliverdOrder({super.key});

  @override
  State<DeliverdOrder> createState() => _DeliverdOrderState();
}

class _DeliverdOrderState extends State<DeliverdOrder> {
  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size;
    var deliverOrderProvider = Provider.of<DeliverOrderProvider>(context);
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: deliverOrderProvider.postList.length,
      itemBuilder: (context, index) {
        DeliverOrderModal modalResponse =
            deliverOrderProvider.getPostByIndex(index);
        return InkWell(
          onTap: () {
            getOrderProductResponse(
                uniqID: modalResponse.uniqueId, context: context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfirmedOrder(
                  orderId: modalResponse.rowId,
                  address: modalResponse.address,
                  delivery: modalResponse.delivery,
                  userName: modalResponse.userId,
                  productCount: modalResponse.productCount,
                  storeId: modalResponse.storeId,
                  uniqueID: modalResponse.uniqueId,
                  userPhone: modalResponse.userPhone,
                  closed: false,
                  userLat: modalResponse.userLong,
                  userLong: modalResponse.userLong,
                ),
              ),
            );
          },
          child: Row(
            children: [
              productCountBox(
                context: context,
                cardColor: Colors.orangeAccent,
                delivery: modalResponse.delivery,
                itemCount: modalResponse.productCount,
              ),
              SizedBox(
                width: widgetSize.width / 1.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      modalResponse.userId,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    normalTextWithPadding(labelText: modalResponse.address),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
