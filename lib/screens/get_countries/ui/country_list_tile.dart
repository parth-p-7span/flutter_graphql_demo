import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graphql/screens/get_countries/model/country.dart';
import 'package:flutter_graphql/screens/get_countries/ui/dialog/country_detail_dialog.dart';
import 'package:flutter_graphql/screens/get_countries/ui/helper/dialog_helper.dart';
import 'package:flutter_graphql/theme_data.dart';
import 'package:google_fonts/google_fonts.dart';

class CountryListTileWidget extends StatelessWidget {
  final Country? country;

  const CountryListTileWidget({Key? key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Card(
        elevation: 0,
        color: MyTheme.listTileColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.only(bottom: 1),
        child: InkWell(
          onTap: () {
            DialogHelper.show(context, country!);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  country?.name.toString() ?? "",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
