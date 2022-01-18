import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graphql/auth/ui/logout_dialog.dart';
import 'package:flutter_graphql/screens/get_continent/bloc/continent_bloc.dart';
import 'package:flutter_graphql/screens/get_continent/di/continent_module.dart';
import 'package:flutter_graphql/screens/get_continent/model/continent_data.dart';
import 'package:flutter_graphql/screens/get_continent/state/get_continents_state.dart';
import 'package:flutter_graphql/screens/get_countries/ui/countries_page.dart';
import 'package:flutter_graphql/screens/user_details/ui/user_detail_page.dart';
import 'package:flutter_graphql/theme_data.dart';
import 'package:flutter_graphql/utils/app_utils.dart';
import 'package:flutter_graphql/widgets/shimmer_effect.dart';
import 'package:google_fonts/google_fonts.dart';

class ContinentPage extends StatefulWidget {
  const ContinentPage({Key? key}) : super(key: key);

  @override
  _ContinentPageState createState() => _ContinentPageState();
}

class _ContinentPageState extends State<ContinentPage> {
  ContinentBloc? _continentBloc;
  String? value;

  @override
  void initState() {
    // TODO: implement initState
    _continentBloc = ContinentModule().getContinents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
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
          "Select Continent",
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
        width: double.infinity,
        color: Colors.white,
        child: StreamBuilder<GetContinentsState>(
          stream: _continentBloc?.getContinentStateStream,
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state?.isLoading() ?? false) {
              return buildShimmerLoading();
            }
            if (state?.isError() ?? false) {
              print("error");
            }
            return StreamBuilder<ContinentData?>(
              stream: _continentBloc?.continentDataStream,
              initialData: _continentBloc?.continentDataStream.valueOrNull,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<DropdownMenuItem<String>>? items =
                      snapshot.data?.continents
                          ?.map(
                            (e) => DropdownMenuItem(
                              child: Text(
                                e.name ?? "",
                                style: MyTheme.latoText(15, Colors.black45),
                              ),
                              value: e.code,
                            ),
                          )
                          .toList();
                  return Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: MyTheme.dropDownColor,
                              ),
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    items: items,
                                    hint: Text(
                                      "Select Continent",
                                      style: MyTheme.latoText(15, Colors.black),
                                    ),
                                    value: value,
                                    onChanged: (String? val) {
                                      setState(() {
                                        value = val;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                if (value?.isNotEmpty ?? false) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CountriesPage(
                                                continent: value,
                                              )));
                                } else {
                                  AppUtils.showSnackBar(
                                    'Select continent first!',
                                    _scaffoldKey,
                                    isError: false,
                                  );
                                }
                              },
                              child: Text(
                                "Get",
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    MyTheme.appbarTitleColor),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            );
          },
        ),
      ),
    );
  }
}

Widget buildShimmerLoading() {
  return Padding(
    padding: const EdgeInsets.only(top: 50),
    child: ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: ShimmerWidget.rectangular(
            height: 40,
            shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        );
      },
      itemCount: 2,
    ),
  );
}
