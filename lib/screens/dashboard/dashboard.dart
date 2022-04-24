import 'package:flutter/material.dart';
import 'package:flutter_graphql/auth/ui/logout_dialog.dart';
import 'package:flutter_graphql/screens/badges/ui/badges_page.dart';
import 'package:flutter_graphql/screens/get_continent/ui/continent_page.dart';
import 'package:flutter_graphql/screens/notifications/api/notification_api.dart';
import 'package:flutter_graphql/screens/notifications/ui/notification_clicked_page.dart';
import 'package:flutter_graphql/screens/notifications/ui/notification_page.dart';
import 'package:flutter_graphql/screens/polls/ui/poll_page.dart';
import 'package:flutter_graphql/screens/user_details/ui/user_detail_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme_data.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    NotificationApi.init();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NotificationClickedPage(payload: payload)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserDetailPage()));
          },
          icon: Icon(
            Icons.menu,
            color: Colors.black54,
          ),
        ),
        title: Text(
          "Dashboard",
          style: GoogleFonts.lato(textStyle: TextStyle(color: Colors.black54)),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context, builder: (context) => LogoutDialog());
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black54,
              ))
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                GotoBtn(context, "Select Continent", '/continent'),
                GotoBtn(context, "Poll Section", '/poll'),
                GotoBtn(context, "Go to Badges", '/badges'),
                GotoBtn(context, "Timer Notification", '/timerNotification'),
                GotoBtn(context, "Searchable Dropdown", '/searchableDropdown'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget GotoBtn(BuildContext context, String txt, String routeName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(routeName);
          },
          child: Text(
            txt,
            style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(MyTheme.appbarTitleColor),
          ),
        ),
      ),
    );
  }
}
