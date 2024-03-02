import 'package:cartlistmurchant/FUNCTION/apiCallback.dart';
import 'package:cartlistmurchant/MODAL/conformOrderModal.dart';
import 'package:cartlistmurchant/PROVIDER/confirmOrderProvider.dart';
import 'package:cartlistmurchant/SCREEN/STATICS/confirmedOrder.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistCard.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistText.dart';
import 'package:cartlistmurchant/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ConfirmList extends StatefulWidget {
  const ConfirmList({super.key});

  @override
  State<ConfirmList> createState() => _ConfirmListState();
}

class _ConfirmListState extends State<ConfirmList> {
  @override
  Widget build(BuildContext context) {
    var confirmOrderProvider = Provider.of<ConfirmOrderProvider>(context);
    final widgetSize = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: confirmOrderProvider.postList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        ConfirmOrderModal modalResponse =
            confirmOrderProvider.getPostByIndex(index);
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
                  userLat: modalResponse.userLat,
                  userLong: modalResponse.userLong,
                ),
              ),
            );
          },
          child: Row(
            children: [
              productCountBox(
                context: context,
                cardColor: Colors.green,
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
