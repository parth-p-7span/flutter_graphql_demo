import 'package:flutter/material.dart';

class CustomAppbar2 extends AppBar {
  final BuildContext context;
  final String titleTxt;

  CustomAppbar2(
      {required this.context,
      required this.titleTxt,
      Widget? leading,
      List<Widget>? actions})
      : super(leading: leading, actions: actions);
}
