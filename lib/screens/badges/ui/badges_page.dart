import 'package:flutter/material.dart';
import 'package:flutter_graphql/screens/badges/bloc/badges_bloc.dart';
import 'package:flutter_graphql/screens/badges/di/badges_module.dart';
import 'package:flutter_graphql/screens/badges/model/badge_data.dart';
import 'package:flutter_graphql/screens/badges/model/response/applied_badge_filter.dart';
import 'package:flutter_graphql/screens/badges/state/get_badges_state.dart';
import 'package:flutter_graphql/screens/badges/ui/badges_filter_page.dart';
import 'package:flutter_graphql/utils/app_utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme_data.dart';

class BadgesPage extends StatefulWidget {
  const BadgesPage({Key? key}) : super(key: key);

  @override
  _BadgesPageState createState() => _BadgesPageState();
}

class _BadgesPageState extends State<BadgesPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late BadgesBloc _badgesBloc;
  int totalCount = 0;
  bool isSearch = false;

  @override
  void initState() {
    _badgesBloc = BadgesModule().getBadgesBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: !isSearch
            ? Text(
                "Badges",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(color: MyTheme.appbarTitleColor),
                ),
              )
            : TextField(
                cursorHeight: 20,
                autofocus: true,
                onChanged: (text) {
                  _badgesBloc.searchQueryStream.add(text);
                },
                decoration: InputDecoration(
                    hintText: "Search", border: InputBorder.none),
              ),
        leading: !isSearch ? BackButton(color: MyTheme.appbarTitleColor) : null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          !isSearch
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      this.isSearch = !this.isSearch;
                    });
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black54,
                  ))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      this.isSearch = !this.isSearch;
                    });
                  },
                  icon: Icon(Icons.close, color: Colors.black54)),
          IconButton(
            onPressed: () {
              _showFilterPage();
            },
            icon: Icon(
              Icons.sort,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder<GetBadgesState>(
          stream: _badgesBloc.getBadgesStateStream,
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state?.isLoading() ?? false) {
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            }
            if (state?.isError() ?? false) {
              print("Error State !!!!!!!!!!!!");
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                AppUtils.showSnackBar(
                  state?.error?.toString() ??
                      'Something went wrong, please try again!',
                  _scaffoldKey,
                  isError: true,
                );
              });
            }
            return StreamBuilder<BadgesData>(
              stream: _badgesBloc.badgesDataStream,
              initialData: _badgesBloc.badgesDataStream.valueOrNull,
              builder: (context, snapshot) {
                final items = snapshot.data?.badges ?? [];
                if (items.isEmpty) {
                  return Container(
                      child: Center(child: Text("Data not found")));
                }
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: ListTile(
                        title: Text(items[index].name ?? ""),
                        tileColor: MyTheme.dropDownColor,
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showFilterPage() async {
    final appliedFilter = await showModalBottomSheet<AppliedBadgeFilter>(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            BadgesFilterPage(
                appliedBadgeFilter: _badgesBloc.badgesDataStream.value.filter)
          ],
        );
      },
      isScrollControlled: true,
    );
    if (appliedFilter != null) {
      _badgesBloc.applyFilter(appliedFilter);
    }
  }
}
