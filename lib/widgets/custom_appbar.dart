import 'package:flutter/material.dart';
import 'package:flutter_graphql/theme_data.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  final Size preferredSize;
  final String title;
  final bool backBtn;
  CustomAppbar(this.title, this.backBtn, {Key? key})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: backBtn
          ? BackButton(
              color: MyTheme.appbarTitleColor,
            )
          : null,
      title: Text(
        title,
        style: GoogleFonts.lato(
            textStyle: TextStyle(color: MyTheme.appbarTitleColor)),
      ),
      backgroundColor: Colors.white,
      elevation: 1,
    );
  }
}
