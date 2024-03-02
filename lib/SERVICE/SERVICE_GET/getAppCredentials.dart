import 'dart:convert';
import 'dart:io';
import 'package:cartlistmurchant/HELPER/categoryNetworkResponse.dart';
import 'package:cartlistmurchant/MODAL/cartlistCredentials.dart';
import 'package:http/http.dart';

class CartlistCredential {
  static Future<NetworkResponse<CartistCredentials>>
      getCartlistCredentials() async {
    try {
      final response = await get(Uri.parse(
          'http://18.183.210.225/cartlistapp_api/cartlist/get_data/function_cartlist.php'));

      print(response.body);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        CartistCredentials categoryResponse = CartistCredentials.fromJson(body);

        return NetworkResponse(true, categoryResponse,
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
}
