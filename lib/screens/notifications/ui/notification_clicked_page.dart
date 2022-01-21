import 'package:flutter/material.dart';
import 'package:flutter_graphql/theme_data.dart';

class NotificationClickedPage extends StatelessWidget {
  final String? payload;
  const NotificationClickedPage({Key? key, this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: MyTheme.appbarTitleColor),
        title: Text("Notification clicked page",
            style: TextStyle(color: MyTheme.appbarTitleColor)),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text("You have tapped notification!"),
              SizedBox(height: 30),
              Text(payload!),
            ],
          ),
        ),
      ),
    );
  }
}
