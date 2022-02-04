import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final bool loading;
  final String text;
  final void Function()? onPress;
  const LoadingButton({
    Key? key,
    required this.loading,
    required this.text,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: Text(text),
      icon: loading
          ? Container(
              padding: const EdgeInsets.only(left: 10),
              height: 20,
              width: 30,
              child: CircularProgressIndicator(
                color: Colors.grey[300],
              ),
            )
          : const SizedBox(),
      onPressed: onPress,
    );
  }
}
