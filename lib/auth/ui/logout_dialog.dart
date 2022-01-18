import 'package:flutter/material.dart';
import 'package:flutter_graphql/di/app_module.dart';
import 'package:flutter_graphql/theme_data.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_page.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  _LogoutDialogState createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Do you want to logout?",
                  style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(fontSize: 20, color: Colors.black54)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          AppModule()
                              .sharedPreferenceManager
                              .removeKey("session");
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage()),
                              (Route<dynamic> route) => false);
                        },
                        child: Text("Yes", style: GoogleFonts.lato()),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                MyTheme.appbarTitleColor)),
                      )),
                  Container(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("No", style: GoogleFonts.lato()),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              MyTheme.appbarTitleColor)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
