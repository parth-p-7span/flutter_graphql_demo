import 'package:flutter/material.dart';
import 'package:flutter_graphql/base/base_bloc.dart';
import 'package:flutter_graphql/base/base_state.dart';
import 'package:flutter_graphql/screens/badges/bloc/badge_filter_bloc.dart';
import 'package:flutter_graphql/screens/badges/di/badges_module.dart';
import 'package:flutter_graphql/screens/badges/model/response/applied_badge_filter.dart';
import 'package:flutter_graphql/theme_data.dart';
import 'package:flutter_graphql/widgets/custom_radio_button.dart';

class BadgesFilterPage extends StatefulWidget {
  final AppliedBadgeFilter? appliedBadgeFilter;

  const BadgesFilterPage({Key? key, this.appliedBadgeFilter}) : super(key: key);

  @override
  _BadgesFilterPageState createState() => _BadgesFilterPageState();
}

class _BadgesFilterPageState extends BaseState<BadgesFilterPage> {
  late BadgeFilterBloc _badgeFilterBloc;

  @override
  void initState() {
    _badgeFilterBloc =
        BadgesModule().getBadgeFilterBloc(widget.appliedBadgeFilter);
    super.initState();
  }

  String _value = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: [
            /// title and close icon
            Row(
              children: [
                Text(
                  "Filter",
                  style: MyTheme.latoText(20, Colors.black),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            SizedBox(height: 20),

            /// status btns
            Row(
              children: [
                Text(
                  "Status",
                  style: MyTheme.latoText(20, Colors.black54),
                ),
                Spacer(),
                MyRadioListTile<String>(
                    value: "active",
                    groupValue: _value,
                    onChanged: (value) => setState(() => _value = value!),
                    leading: "Active"),
                MyRadioListTile<String>(
                    value: "inactive",
                    groupValue: _value,
                    onChanged: (value) => setState(() => _value = value!),
                    leading: "Inactive"),
              ],
            ),
            SizedBox(height: 20),

            /// filter btn
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _badgeFilterBloc.selectedStatusStream.add(_value);
                  Navigator.pop(context, _badgeFilterBloc.getAppliedFilter());
                },
                child: Text(
                  "Apply",
                  style: MyTheme.latoText(18, Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(MyTheme.appbarTitleColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  BaseBloc getBaseBloc() {
    return _badgeFilterBloc;
  }
}
