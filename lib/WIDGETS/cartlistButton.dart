import 'package:cartlistmurchant/const.dart';
import 'package:flutter/material.dart';

Widget textIocnButtonBlack({
  required String buttonText,
  required IconData buttonIcon,
}) {
  return TextButton.icon(
    onPressed: () {},
    icon: Icon(
      buttonIcon,
      size: 15,
      color: colorBlack,
    ),
    label: Text(
      buttonText,
      style: TextStyle(color: colorBlack),
    ),
  );
}

Widget textIocnButtonRed({
  required String buttonText,
  required IconData buttonIcon,
}) {
  return TextButton.icon(
    onPressed: () {},
    icon: Icon(
      buttonIcon,
      size: 15,
      color: colorRed,
    ),
    label: Text(
      buttonText,
      style: TextStyle(color: colorRed),
    ),
  );
}

Widget loginButton({
  required BuildContext context,
  required String buttonText,
  required void Function() buttonAction,
}) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: colorPrimary),
        onPressed: buttonAction,
        child: Text(
          buttonText,
          style: const TextStyle(color: colorWhite),
        ),
      ),
    ),
  );
}
