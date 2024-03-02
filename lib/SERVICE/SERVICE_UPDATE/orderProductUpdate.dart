import 'dart:convert';
import 'dart:io';
import 'package:cartlistmurchant/HELPER/categoryNetworkResponse.dart';
import 'package:cartlistmurchant/MODAL/createDataModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<NetworkResponse<CreateUserModal>> updateOrderProduct({
  required BuildContext context,
  required String verify,
  required String stockId,
  required String confirmid,
}) async {
  try {
    final data = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://18.183.210.225/cartlistapp_api/store/update_data/update_stockproduct.php'));
    data.fields.addAll({
      'pass_verify': verify,
      'pass_stockid': stockId,
      'pass_confirmid': confirmid,
    });

    http.StreamedResponse response = await data.send();

    if (response.statusCode == 200) {
      final responsString = json.decode(await response.stream.bytesToString());

      CreateUserModal updateCartDatamodal =
          CreateUserModal.fromJson(responsString);

      return NetworkResponse(true, updateCartDatamodal,
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
