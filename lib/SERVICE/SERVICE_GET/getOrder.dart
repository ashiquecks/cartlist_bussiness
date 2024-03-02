import 'dart:convert';
import 'dart:io';
import 'package:cartlistmurchant/HELPER/categoryNetworkResponse.dart';
import 'package:cartlistmurchant/MODAL/orderModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

Future<NetworkResponse<List<OrderModal>>> getOrderApi({
  required BuildContext context,
  required String storeID,
}) async {
  try {
    final response = await get(Uri.parse(
        'http://18.183.210.225/cartlistapp_api/store/get_data/getorder.php?storeID=$storeID'));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      List<OrderModal> dataList = [];
      body.forEach((e) {
        OrderModal orderResponse = OrderModal.fromJson(e);
        dataList.add(orderResponse);
      });

      return NetworkResponse(true, dataList, responseCode: response.statusCode);
    } else {
      return NetworkResponse(false, null,
          message:
              'Invalid response recived from server! please try again in a minutes or two',
          responseCode: response.statusCode);
    }
  } on SocketException {
    return NetworkResponse(
      false,
      null,
      message:
          "Unable to reach the internet! Ple ase try again in  a minutes or two",
    );
  } on FormatException {
    return NetworkResponse(
      false,
      null,
      message:
          "Invalid response receved form the server! Please try again in a minutes or two",
    );
  } catch (e) {
    return NetworkResponse(false, null,
        message: 'somthing went wrong please try again in a minute or two');
  }
  throw Exception('Unexpected error occured!');
}
