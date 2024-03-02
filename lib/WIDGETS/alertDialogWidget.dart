import 'package:cartlistmurchant/WIDGETS/cartlistText.dart';
import 'package:cartlistmurchant/const.dart';
import 'package:flutter/material.dart';

showAlertDialogRefresh({
  required BuildContext context,
}) {
  AlertDialog alert = AlertDialog(
    elevation: 0,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    content: Container(
      height: 80,
      color: Colors.transparent,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        strokeWidth: 5,
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop(true);
      });
      return alert;
    },
  );
}

Widget scafoldMessageBox(
    {required BuildContext context, required String message}) {
  return Card(
    elevation: 12,
    margin: const EdgeInsets.all(15),
    child: Container(
      color: colorWhite,
      width: MediaQuery.of(context).size.width / 3,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.check_circle,
            color: colorPrimary,
            size: 40,
          ),
          normalTextWithPaddingSize(labelText: message, textCilor: colorBlack)
        ],
      ),
    ),
  );
}

Widget scafoldMessageBoxLoading({required BuildContext context}) {
  return Card(
    elevation: 12,
    margin: const EdgeInsets.all(15),
    child: Container(
      color: colorWhite,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: CircularProgressIndicator(
              color: colorPrimary,
            ),
          ),
          normalTextWithPaddingSize(
            labelText: "Loading...",
            textCilor: colorBlack,
          ),
          const SizedBox(width: 10),
        ],
      ),
    ),
  );
}
