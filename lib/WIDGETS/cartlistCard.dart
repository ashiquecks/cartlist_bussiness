import 'package:cartlistmurchant/PROVIDER/registrationProvider.dart';
import 'package:cartlistmurchant/SERVICE/SERVICE_UPDATE/storeStatusupdate.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistButton.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistText.dart';
import 'package:cartlistmurchant/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

Widget shopProfileCardHead({
  required BuildContext context,
  required String storeImage,
  required String storeName,
  required String storeType,
  required String storeId,
}) {
  return Stack(
    children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4.7,
        color: colorPrimary,
      ),
      Positioned(
        right: 10,
        top: 60,
        child: ToggleSwitch(
          minWidth: 90.0,
          cornerRadius: 20.0,
          activeBgColors: [
            [Colors.green[800]!],
            [Colors.red[800]!]
          ],
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.black,
          inactiveFgColor: Colors.white,
          totalSwitches: 2,
          labels: ['Open', 'Closed'],
          radiusStyle: true,
          onToggle: (index) {
            updateStoreStatus(
                context: context, status: index.toString(), storeId: storeId);
          },
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
        child: Row(
          children: [
            Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  storeImage,
                  width: 120,
                  height: 120,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    storeName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(storeType),
                ),
              ],
            )
          ],
        ),
      ),
    ],
  );
}

Widget staticGridCard({
  required Color cardColor,
  required String cardLable,
  required Color labelColor,
  required String orderCount,
  required void Function() cardAction,
}) {
  DateTime now = new DateTime.now();
  return InkWell(
    onTap: cardAction,
    child: Card(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              cardLable,
              style: TextStyle(color: labelColor),
            ),
            Text(
              orderCount,
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: colorWhite,
              ),
            ),
            textIocnButtonBlack(
                buttonText: "${now.day}/${now.month}/${now.year}",
                buttonIcon: Icons.calendar_month_rounded),
          ],
        ),
      ),
    ),
  );
}

Widget staticListCard({
  required Color cardColor,
  required String cardLable,
  required Color labelColor,
  required String orderCount,
  required void Function() cardAction,
  required String purchasedate,
}) {
  DateTime now = new DateTime.now();
  return InkWell(
    onTap: cardAction,
    child: Card(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  cardLable,
                  style: TextStyle(color: labelColor),
                ),
                Text(
                  orderCount,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: colorWhite,
                  ),
                ),
                textIocnButtonBlack(
                    buttonText: purchasedate, buttonIcon: Icons.location_pin),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 50,
              color: colorWhite,
            )
          ],
        ),
      ),
    ),
  );
}

Widget colorCube() {
  return Container(
    margin: const EdgeInsets.all(5),
    width: 30,
    height: 10,
    decoration: BoxDecoration(
      color: colorPrimary,
      borderRadius: BorderRadius.circular(15),
    ),
  );
}

Widget borderCube() {
  return Container(
    margin: const EdgeInsets.all(5),
    width: 30,
    height: 10,
    decoration: BoxDecoration(
      border: Border.all(),
      borderRadius: BorderRadius.circular(15),
    ),
  );
}

Widget productCountBox(
    {required BuildContext context,
    required Color cardColor,
    required String delivery,
    required String itemCount}) {
  return Card(
    color: cardColor,
    elevation: 4,
    margin: EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          normalTextWithPaddingColor(
              labelText: delivery, textCilor: colorWhite),
          Text(
            itemCount,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: colorWhite,
            ),
          ),
          normalTextWithPaddingColor(labelText: "Items", textCilor: colorWhite),
        ],
      ),
    ),
  );
}
