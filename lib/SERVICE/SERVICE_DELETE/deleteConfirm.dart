import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void deleteConfirmOrder({
  required BuildContext context,
  required String rowId,
}) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://18.183.210.225/cartlistapp_api/store/delete_data/deleteconfirm_order.php'));
  request.fields.addAll({'pass_rowId': '$rowId'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
