// Category Response Post To Category Provider

import 'package:cartlistmurchant/PROVIDER/categoryProvider.dart';
import 'package:cartlistmurchant/PROVIDER/confirmOrderProvider.dart';
import 'package:cartlistmurchant/PROVIDER/deliverOrderProvider.dart';
import 'package:cartlistmurchant/PROVIDER/orderProductProvider.dart';
import 'package:cartlistmurchant/PROVIDER/orderProvider.dart';
import 'package:cartlistmurchant/SERVICE/SERVICE_GET/getCategory.dart';
import 'package:cartlistmurchant/SERVICE/SERVICE_GET/getConfirmOrder.dart';
import 'package:cartlistmurchant/SERVICE/SERVICE_GET/getDeliverdOrder.dart';
import 'package:cartlistmurchant/SERVICE/SERVICE_GET/getOrder.dart';
import 'package:cartlistmurchant/SERVICE/SERVICE_GET/getOrderProduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

getCategoryResponse({required BuildContext context}) async {
  var provider = Provider.of<CategoryProvider>(context, listen: false);
  var response = await Categoryservice.getCategoryResponse();

  if (response.isSuccessful!) {
    provider.setPostList(response.data!);
  } else if (response.message ==
      "Unable to reach the internet! Ple ase try again in  a minutes or two") {
    Navigator.pushNamed(context, '/lossConnection');
  } else {}
}

getOrderResponse({
  required String profileID,
  required BuildContext context,
}) async {
  var provider = Provider.of<OrderProvider>(context, listen: false);
  var response =
      await getOrderApi(context: context, storeID: profileID.toString());

  if (response.isSuccessful!) {
    provider.setPostList(response.data!);
  } else if (response.message ==
      "Unable to reach the internet! Ple ase try again in  a minutes or two") {
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, '/lossConnection');
  } else {}
}

getConfirmOrderResponse({
  required String profileID,
  required BuildContext context,
}) async {
  var provider = Provider.of<ConfirmOrderProvider>(context, listen: false);
  var response = await getConfirmedOrderApi(
      context: context, storeID: profileID.toString());

  if (response.isSuccessful!) {
    provider.setPostList(response.data!);
  } else if (response.message ==
      "Unable to reach the internet! Ple ase try again in  a minutes or two") {
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, '/lossConnection');
  } else {}
}

getDeliverOrderResponse({
  required String profileID,
  required BuildContext context,
}) async {
  var provider = Provider.of<DeliverOrderProvider>(context, listen: false);
  var response = await getDeliverdOrderApi(
      context: context, storeID: profileID.toString());

  if (response.isSuccessful!) {
    if (response.data!.length == provider.postList.length) {
      print("no extra value");
    } else if (response.data!.length > provider.postList.length) {
      provider.setPostList(response.data!);
    } else {
      print("no extra value");
    }
  } else if (response.message ==
      "Unable to reach the internet! Ple ase try again in  a minutes or two") {
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, '/lossConnection');
  } else {}
}

getOrderProductResponse(
    {required String uniqID, required BuildContext context}) async {
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
