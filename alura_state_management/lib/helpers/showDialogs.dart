import 'package:flutter/material.dart';
import '../components/response_dialog.dart';

Future<dynamic> showErrorDialog(BuildContext context,
    {String message = 'Unknow error!'}) {
  return showDialog(
    context: context,
    builder: (ctxDialog) {
      return ErrorDialog(
        message: message,
      );
    },
  );
}

Future<dynamic> showSuccessDialog(BuildContext context,
    {String message = 'Succeded!'}) {
  return showDialog(
    context: context,
    builder: (ctxDialog) {
      return SuccessDialog(
        message: message,
      );
    },
  );
}
