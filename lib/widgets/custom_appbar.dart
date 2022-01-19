import 'package:flutter/material.dart';
import 'package:flutter_graphql/auth/ui/login_page.dart';
import 'package:flutter_graphql/session/di/session_module.dart';
import 'package:flutter_graphql/theme_data.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends StatefulWidget with PreferredSizeWidget {
  final Size preferredSize;
  final String title;
  final bool backBtn;
  final bool logoutBtn;
  final bool sortingBtn;

  CustomAppbar(this.title, this.backBtn, this.logoutBtn, this.sortingBtn,
      {Key? key})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  _CustomAppbarState createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.backBtn
          ? BackButton(
              color: MyTheme.appbarTitleColor,
            )
          : null,
      title: Text(
        widget.title,
        style: GoogleFonts.lato(
            textStyle: TextStyle(color: MyTheme.appbarTitleColor)),
      ),
      backgroundColor: Colors.white,
      elevation: 1,
      actions: [
        widget.sortingBtn
            ? IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.sort_sharp,
                  color: Colors.black54,
                ))
            : Container()
      ],
    );
  }
}
