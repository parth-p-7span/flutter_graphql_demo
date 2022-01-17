import 'package:flutter/material.dart';
import 'package:flutter_graphql/auth/ui/signup_page.dart';
import 'package:flutter_graphql/screens/get_continent/ui/continent_page.dart';
import 'package:flutter_graphql/screens/get_countries/ui/countries_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  runApp(MaterialApp(
    title: 'GQL demo',
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignupPage();
  }
}
