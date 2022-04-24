import 'package:flutter/material.dart';
import 'package:flutter_graphql/auth/ui/login_page.dart';
import 'package:flutter_graphql/base/base_state.dart';
import 'package:flutter_graphql/screens/dashboard/dashboard.dart';
import 'package:flutter_graphql/session/di/session_module.dart';
import 'package:flutter_graphql/session/model/session.dart';
import 'package:flutter_graphql/session/repo/session_repo.dart';
import 'package:flutter_graphql/theme_data.dart';
import 'package:flutter_graphql/utils/route_generator.dart';

import 'base/base_bloc.dart';

void main() async {
  runApp(MaterialApp(
    title: 'My app',
    initialRoute: '/',
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends BaseState<MyApp> {
  late SessionRepo _sessionRepo;
  @override
  void initState() {
    _sessionRepo = SessionModule().getSessionRepo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Session>(
        stream: _sessionRepo.getSession(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              return DashboardPage();
            } else {
              return LoginPage();
            }
          } else {
            return Container(
              color: MyTheme.splashColor,
              child: Center(
                child: Image.asset(
                  'assets/images/splash.png',
                  height: 100,
                  width: 100,
                ),
              ),
            );
          }
        });
  }

  @override
  BaseBloc? getBaseBloc() {
    return null;
  }
}
