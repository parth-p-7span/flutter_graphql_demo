import 'package:flutter/material.dart';
import 'package:flutter_graphql/screens/notifications/api/notification_api.dart';
import 'package:flutter_graphql/screens/notifications/ui/notification_clicked_page.dart';
import 'package:flutter_graphql/theme_data.dart';
import 'package:flutter_graphql/utils/app_utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerNotification extends StatefulWidget {
  const TimerNotification({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<TimerNotification> {
  TimeOfDay selectedTime = TimeOfDay.now();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isTimeSelected = false;

  @override
  void initState() {
    super.initState();
    NotificationApi.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Timer Notification",
          style: GoogleFonts.lato(
              textStyle: TextStyle(color: MyTheme.appbarTitleColor)),
        ),
        leading: BackButton(
          color: MyTheme.appbarTitleColor,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 40),

            /// pick time btn
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _selectTime(context);
                },
                child: Text("Pick Time"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.appbarTitleColor),
                ),
              ),
            ),

            Container(
              child: isTimeSelected
                  ? Text("Selected time : " +
                      selectedTime.hour.toString() +
                      " : " +
                      selectedTime.minute.toString())
                  : Container(),
            ),

            /// set notification btn
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (!isTimeSelected) {
                    AppUtils.showSnackBar("Select time first!", _scaffoldKey);
                  }
                  if (selectedTime != TimeOfDay.now() && isTimeSelected) {
                    NotificationApi.showTimerNotification(
                        title: "Quick Remainder",
                        body: "this is the body section of test notification.",
                        selectedTime: selectedTime,
                        payload: "payload is " + selectedTime.toString());

                    AppUtils.showSnackBar(
                        "Notification is successfully set!", _scaffoldKey);
                  }
                },
                child: Text("Set Notification"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.appbarTitleColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        isTimeSelected = true;
      });
    }
  }
}
