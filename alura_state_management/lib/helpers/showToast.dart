import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(
    {required String message,
    int duration = 5,
    ToastGravity position = ToastGravity.BOTTOM,
    Color textColor = Colors.black,
    Color backgroundColor = Colors.grey}) {
  return Fluttertoast.showToast(
    msg: message,
    textColor: textColor,
    backgroundColor: backgroundColor,
    gravity: position,
    timeInSecForIosWeb: duration,
  );
}

showErrorToast({
  String message = 'Unknow Error!',
}) {
  return showToast(
    message: message,
    textColor: Colors.red,
  );
}

showSuccessToast({
  String message = 'Succeded!',
}) {
  return showToast(
    message: message,
    textColor: Colors.green,
  );
}
