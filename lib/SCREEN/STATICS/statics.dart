import 'package:cartlistmurchant/FUNCTION/apiCallback.dart';
import 'package:cartlistmurchant/MODAL/conformOrderModal.dart';
import 'package:cartlistmurchant/PROVIDER/confirmOrderProvider.dart';
import 'package:cartlistmurchant/PROVIDER/deliverOrderProvider.dart';
import 'package:cartlistmurchant/PROVIDER/orderProductProvider.dart';
import 'package:cartlistmurchant/SCREEN/STATICS/cancelOrderList.dart';
import 'package:cartlistmurchant/SCREEN/STATICS/confirmList.dart';
import 'package:cartlistmurchant/SCREEN/STATICS/confirmedOrder.dart';
import 'package:cartlistmurchant/SCREEN/STATICS/deliverdOrder.dart';
import 'package:cartlistmurchant/SERVICE/SERVICE_GET/getOrderProduct.dart';
import 'package:cartlistmurchant/SHAREPREF/cartlistSharepref.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistCard.dart';
import 'package:cartlistmurchant/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StaticsScreen extends StatefulWidget {
  const StaticsScreen({super.key});

  @override
  State<StaticsScreen> createState() => _StaticsScreenState();
}

class _StaticsScreenState extends State<StaticsScreen> {
  DateTime now = new DateTime.now();

  String groupValue = "Delivery";

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

  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    ConfirmList(),
    DeliverdOrder(),
    CancelOrdrList()
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var deliverOrderProvider = Provider.of<DeliverOrderProvider>(context);
    var confirmOrderProvider = Provider.of<ConfirmOrderProvider>(context);
    final widgetSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const SizedBox(),
        leadingWidth: 0,
        title: const Text(
          "Statics",
          style: TextStyle(color: colorPrimary),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: widgetSize.height / 4,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  staticGridCard(
                    cardLable: "Confirmed Order",
                    labelColor: colorWhite,
                    orderCount: confirmOrderProvider.postList.length.toString(),
                    cardAction: () {
                      onItemTapped(0);
                    },
                    cardColor: Colors.green,
                  ),
                  staticGridCard(
                    cardLable: "Deliverd Order",
                    labelColor: colorWhite,
                    orderCount: deliverOrderProvider.postList.length.toString(),
                    cardAction: () {
                      onItemTapped(1);
                    },
                    cardColor: Colors.orangeAccent,
                  ),
                  staticGridCard(
                    cardLable: "Cancel Order",
                    labelColor: colorWhite,
                    orderCount: "0",
                    cardAction: () {
                      onItemTapped(2);
                    },
                    cardColor: Colors.redAccent,
                  ),
                ],
              ),
            ),
            SizedBox(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ],
        ),
      ),
    );
  }
}

//  staticGridCard(
//                       cardLable: "Confirmed Order",
//                       labelColor: colorWhite,
//                       orderCount:
//                           confirmOrderProvider.postList.length.toString(),
//                       cardAction: () {},
//                       cardColor: Colors.green,
//                     ),


// staticGridCard(
//                       cardLable: "Deliverd Order",
//                       labelColor: colorWhite,
//                       orderCount:
//                           deliverOrderProvider.postList.length.toString(),
//                       cardAction: () {
//                         getDeliverOrderResponse(
//                             profileID: profileID.toString(), context: context);
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: ((context) => const DeliverdOrder())));
//                       },
//                       cardColor: Colors.orangeAccent,
//                     ),
//                     staticGridCard(
//                       cardLable: "Cancel Order",
//                       labelColor: colorWhite,
//                       orderCount: "0",
//                       cardAction: () {},
//                       cardColor: Colors.redAccent,
//                     ),