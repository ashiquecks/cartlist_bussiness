import 'dart:convert';
import 'dart:io';
import 'package:cartlistmurchant/HELPER/categoryNetworkResponse.dart';
import 'package:cartlistmurchant/MODAL/stockProductModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

Future<NetworkResponse<List<StockProductModal>>> getStockByUniqueResponse({
  int limit = 20,
  int page = 1,
  required BuildContext context,
  required String uniqueID,
}) async {
  try {
    final response = await get(Uri.parse(
        'http://18.183.210.225/cartlistapp_api/store/get_data/getorder_product.php?uniqueID=$uniqueID'));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      print(body);

      List<StockProductModal> stockList = [];
      body.forEach((e) {
        StockProductModal stockResponse = StockProductModal.fromJson(e);
        stockList.add(stockResponse);
      });

      return NetworkResponse(true, stockList,
          responseCode: response.statusCode);
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
