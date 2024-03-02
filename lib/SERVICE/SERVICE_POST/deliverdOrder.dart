//C:\xampp\htdocs\cartlistapp_api/store/post_data/confirm_order.php

import 'dart:convert';
import 'dart:io';
import 'package:cartlistmurchant/HELPER/categoryNetworkResponse.dart';
import 'package:cartlistmurchant/MODAL/createDataModal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<NetworkResponse<CreateUserModal>> addDeliverdOrder({
  required BuildContext context,
  required String userId,
  required String storeId, //unique charecter
  required String productCount,
  required String userLat,
  required String userLong,
  required String userPhone,
  required String userAddress,
  required String unqueId,
  required String delivery,
}) async {
  try {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://18.183.210.225/cartlistapp_api/store/post_data/deliverd_order.php'));
    request.fields.addAll({
      'userID': userId,
      'storeID': storeId,
      'productCount': productCount,
      'userLat': userLat,
      'userLong': userLong,
      'userPhone': userPhone,
      'userAddress': userAddress,
      'uniqueID': unqueId,
      'delivery': delivery,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      final jsonString = jsonDecode(await response.stream.bytesToString());

      CreateUserModal stockNamemodal = CreateUserModal.fromJson(jsonString);

      return NetworkResponse(true, stockNamemodal,
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
