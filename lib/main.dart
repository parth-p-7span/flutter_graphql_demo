import 'package:flutter/material.dart';
import 'package:flutter_graphql/auth/ui/login_page.dart';
import 'package:flutter_graphql/screens/get_continent/ui/continent_page.dart';
import 'package:flutter_graphql/session/di/session_module.dart';
import 'package:flutter_graphql/session/model/session.dart';
import 'package:flutter_graphql/session/repo/session_repo.dart';

void main() async {
  runApp(MaterialApp(
    title: 'GQL demo',
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
          print(snapshot.data?.token.toString());
          Future.delayed(const Duration(milliseconds: 500));
          if (snapshot.data != null) {
            return ContinentPage();
          } else {
            return LoginPage();
          }
        });
  }
}
