import 'package:flutter/material.dart';

abstract class BlocView {
  void push(BuildContext blockContext, Widget container) {
    Navigator.of(blockContext).push(
      MaterialPageRoute(builder: (routeContext) => container),
    );
  }
}
