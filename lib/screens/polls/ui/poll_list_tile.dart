import 'package:flutter/material.dart';
import 'package:flutter_graphql/theme_data.dart';
import 'package:google_fonts/google_fonts.dart';

class PollListTile extends StatefulWidget {
  final String? name;
  final String? question;
  final bool isIconVisible;

  const PollListTile(
      {Key? key, this.name, this.question, required this.isIconVisible})
      : super(key: key);

  @override
  _PollListTileState createState() => _PollListTileState();
}

class _PollListTileState extends State<PollListTile> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = GoogleFonts.lato(textStyle: TextStyle(fontSize: 13));
    TextStyle textStyle2 = GoogleFonts.lato(
        color: MyTheme.appbarTitleColor, textStyle: TextStyle(fontSize: 20));

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 8, left: 8),
      child: Card(
        elevation: 0,
        color: MyTheme.dropDownColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.only(bottom: 1),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7, left: 10),
                      child: Text(
                        widget.name ?? "name",
                        style: textStyle2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        widget.question ?? "question",
                        style: textStyle,
                      ),
                    )
                  ],
                ),
              ),
              widget.isIconVisible
                  ? Center(
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(
                          top: 6,
                          bottom: 6,
                          left: 6,
                          right: 6,
                        ),
                        child: Icon(
                          Icons.drag_indicator_sharp,
                          color: Colors.grey[500],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
