import 'package:flutter/material.dart';
import 'package:flutter_graphql/widgets/custom_appbar.dart';
import 'package:flutter_graphql/screens/get_countries/model/country.dart';
import 'package:google_fonts/google_fonts.dart';

class CountryDetailPage extends StatelessWidget {
  final Country? country;
  const CountryDetailPage({Key? key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = GoogleFonts.lato(
        textStyle: TextStyle(fontSize: 30, color: Colors.black45));
    return Scaffold(
      appBar: CustomAppbar(country?.name.toString() ?? "", true),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(top: 25, left: 20),
          child: Column(
            children: [
              CustomText("Code", country?.code.toString() ?? ""),
              CustomText("Name", country?.name.toString() ?? ""),
              CustomText("Currency", country?.currency.toString() ?? ""),
              CustomText("Capital", country?.capital.toString() ?? ""),
              CustomText("Phone", country?.phone.toString() ?? ""),
            ],
          ),
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
        textStyle: TextStyle(fontSize: 30, color: Colors.black45));
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
