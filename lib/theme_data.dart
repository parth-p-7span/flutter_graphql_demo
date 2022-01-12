import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static const appbarTitleColor = const Color(0xff8a0000);
  static const listTileColor = const Color(0xffd4cfcf);
  static const dropDownColor = const Color(0xffebe6e6);

  static TextStyle latoText(double size, Color color) {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: size,
        color: color,
      ),
    );
  }
}
