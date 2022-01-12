import 'package:flutter/material.dart';
import 'package:flutter_graphql/screens/get_countries/model/country.dart';
import 'package:flutter_graphql/theme_data.dart';
import 'package:google_fonts/google_fonts.dart';

class CountryDetailDialog extends StatelessWidget {
  final Country? country;

  const CountryDetailDialog({Key? key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      child: Container(
        height: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(right: 4, left: 12, top: 6, bottom: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Country Details",
                      style: MyTheme.latoText(18, Colors.black),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.grey,
                      ))
                ],
              ),
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.only(
                top: 4,
              ),
              color: Colors.grey.shade300,
            ),
            Container(
              // color: Colors.blue,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomText("Code", country?.code.toString() ?? ""),
                  CustomText("Name", country?.name.toString() ?? ""),
                  CustomText("Currency", country?.currency.toString() ?? ""),
                  CustomText("Capital", country?.capital.toString() ?? ""),
                  CustomText("Phone", country?.phone.toString() ?? "")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String txt1;
  final String txt2;

  const CustomText(this.txt1, this.txt2, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = GoogleFonts.lato(
        textStyle: TextStyle(fontSize: 17, color: Colors.black45));
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$txt1 : ",
            style: _textStyle,
          ),
          Expanded(child: Text(txt2, style: _textStyle))
        ],
      ),
    );
  }
}
