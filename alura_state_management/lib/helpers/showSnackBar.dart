import 'package:flutter/material.dart';

showSnackbar({
  required BuildContext context,
  required String message,
  String actionText = 'OK',
  IconData? icon,
  Color iconColor = Colors.black,
  void Function()? onPress,
  void Function()? onClose,
}) {
  ScaffoldMessenger.of(context)
      .showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(message),
              ),
              icon != null
                  ? Icon(
                      icon,
                      color: iconColor,
                    )
                  : const SizedBox(),
            ],
          ),
          action: SnackBarAction(
              label: actionText,
              onPressed: () {
                onPress != null ? onPress() : () {};
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }),
        ),
      )
      .closed
      .then((_) {
    onClose != null ? onClose() : null;
  });
}

showErrorSnackbar({
  required BuildContext context,
  String message = 'Unknow Error!',
}) {
  return showSnackbar(
    context: context,
    message: message,
    icon: Icons.warning,
    iconColor: Colors.red,
  );
}

showSuccessSnackbar({
  required BuildContext context,
  String message = 'Succeded!',
}) {
  return showSnackbar(
    context: context,
    message: message,
    icon: Icons.check,
    iconColor: Colors.green,
    onClose: () {
      Navigator.pop(context);
    },
  );
}
