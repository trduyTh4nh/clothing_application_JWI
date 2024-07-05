import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

ButtonStyle removeDefaulBorderRadius() {
  return ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Set the border radius to zero
      ),
    ),
  );
}

String formatMoney(int money) {
  var f = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
  String result = f.format(money);
  return result;
}

void snackAlert(String content, BuildContext context) {
  var sb = SnackBar(content: Text(content));
  ScaffoldMessenger.of(context)
      .showSnackBar(sb)
      .closed
      .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
}
