import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void navigateTo(BuildContext context, Widget targetPage) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (routeContext) => targetPage,
    ),
  );
}
