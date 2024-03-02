import 'dart:convert';
import 'dart:io';
import 'package:cartlistmurchant/HELPER/categoryNetworkResponse.dart';
import 'package:cartlistmurchant/MODAL/createDataModal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<NetworkResponse<CreateUserModal>> storeAuth(
    {required BuildContext context,
    required String userMail,
    required String password}) async {
  try {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://18.183.210.225/cartlistapp_api/store/post_data/loginstore.php'));
    request.fields.addAll({'userMail': userMail, 'userPassword': password});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final jsonString = jsonDecode(await response.stream.bytesToString());

      CreateUserModal userDatamodal =
          CreateUserModal.fromJson(await jsonString);

      return NetworkResponse(true, userDatamodal,
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
