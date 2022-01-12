import 'package:flutter/material.dart';
import 'package:flutter_graphql/screens/get_countries/model/country.dart';
import 'package:flutter_graphql/screens/get_countries/ui/dialog/country_detail_dialog.dart';

class DialogHelper {
  static show(context, Country country) {
    return showDialog(
        context: context,
        builder: (context) => FunkyOverlay(
              country: country,
            ));
  }
}

class FunkyOverlay extends StatefulWidget {
  final Country? country;
  const FunkyOverlay({Key? key, this.country}) : super(key: key);

  @override
  _FunkyOverlayState createState() => _FunkyOverlayState();
}

class _FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 270));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: CountryDetailDialog(
        country: widget.country,
      ),
    );
  }
}
