import 'package:flutter/material.dart';

Widget normalTextWithPadding({
  required String labelText,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5, bottom: 5),
    child: Text(labelText),
  );
}

Widget normalTextWithPaddingColor({
  required String labelText,
  required Color textCilor,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5, bottom: 5),
    child: Text(
      labelText,
      style: TextStyle(color: textCilor),
    ),
  );
}

Widget normalTextWithPaddingSize({
  required String labelText,
  required Color textCilor,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5, bottom: 5),
    child: Text(
      labelText,
      style: TextStyle(color: textCilor, fontSize: 18),
    ),
  );
}

Widget cartlistWidgettext({
  required Color widgetColor,
  required IconData textIcon,
  required String labeltext,
}) {
  return RichText(
    text: TextSpan(
      children: [
        WidgetSpan(
            child: Icon(
          textIcon,
          size: 15,
        )),
        TextSpan(
          text: labeltext,
          style: TextStyle(color: widgetColor),
        )
      ],
    ),
  );
}
