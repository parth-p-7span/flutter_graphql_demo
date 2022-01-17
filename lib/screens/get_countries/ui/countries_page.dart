import 'package:flutter/material.dart';
import 'package:flutter_graphql/screens/get_countries/bloc/country_bloc.dart';
import 'package:flutter_graphql/screens/get_countries/di/country_module.dart';
import 'package:flutter_graphql/screens/get_countries/model/country_data.dart';
import 'package:flutter_graphql/screens/get_countries/state/get_countries_state.dart';
import 'package:flutter_graphql/screens/get_countries/ui/country_list_tile.dart';
import 'package:flutter_graphql/widgets/custom_appbar.dart';
import 'package:flutter_graphql/widgets/shimmer_effect.dart';
import 'package:google_fonts/google_fonts.dart';

class CountriesPage extends StatefulWidget {
  final String? continent;
  const CountriesPage({Key? key, this.continent}) : super(key: key);

  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  CountryBloc? _countryBloc;

  @override
  void initState() {
    _countryBloc = CountryModule().geCountries(widget.continent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar("Countries", true),
      body: Container(
        color: Colors.white,
        child: StreamBuilder<GetCountriesState>(
            stream: _countryBloc?.getCountryStateStream,
            builder: (context, snapshot) {
              print("data");
              print(widget.continent);
              final state = snapshot.data;
              if (state?.isLoading() ?? false) {
                return buildShimmerLoading();
              }
              if (state?.isError() ?? false) {
                print("Error State !!!!!!!!!!!!");
              }
              return StreamBuilder<CountryData?>(
                stream: _countryBloc?.countryDataStream,
                initialData: _countryBloc?.countryDataStream.valueOrNull,
                builder: (context, snapshot) {
                  final items = snapshot.data?.countries ?? [];

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        color: Color.fromARGB(1, 20, 25, 66),
                        child: Center(
                          child: CountryListTileWidget(
                            country: items[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }),
      ),
    );
  }
}

Widget buildShimmerLoading() {
  return ListView.builder(
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
        child: ShimmerWidget.rectangular(
          height: 40,
          shapeBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      );
    },
    itemCount: 20,
  );
}
