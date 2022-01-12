import 'package:flutter/material.dart';
import 'package:flutter_graphql/widgets/dropdown_spinner.dart';

class SelectContinentPage extends StatefulWidget {
  final List<String?>? continents;

  const SelectContinentPage({Key? key, this.continents}) : super(key: key);

  @override
  _SelectContinentPageState createState() => _SelectContinentPageState();
}

class _SelectContinentPageState extends State<SelectContinentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white, child: Center());
  }
}
