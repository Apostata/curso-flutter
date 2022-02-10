import 'package:alura_bloc_intl/components/centeredMessage.dart';
import 'package:flutter/material.dart';

class CenteredMessagePage extends StatelessWidget {
  final String message;
  const CenteredMessagePage({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CenteredMessage(message: message),
    );
  }
}
