import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/bloc/items_bloc.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/di/item_module.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/model/item_data.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/state/get_items_state.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/ui/dropdown_dialog.dart';
import 'package:flutter_graphql/theme_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class SearchableDropdownPage extends StatefulWidget {
  const SearchableDropdownPage({Key? key}) : super(key: key);

  @override
  _SearchableDropdownPageState createState() => _SearchableDropdownPageState();
}

class _SearchableDropdownPageState extends State<SearchableDropdownPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late ItemsBloc _itemsBloc;
  String? value;

  @override
  void initState() {
    _itemsBloc = ItemModule().getItemsBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Searchable Dropdown",
          style: GoogleFonts.lato(
              textStyle: TextStyle(color: MyTheme.appbarTitleColor)),
        ),
        leading: BackButton(
          color: MyTheme.appbarTitleColor,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: StreamBuilder<GetItemsState>(
          stream: _itemsBloc.getItemsStateStream,
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state?.isLoading() ?? false) {
              return Center(child: CircularProgressIndicator());
            }
            if (state?.isError() ?? false) {
              print("-----------error");
            }
            return StreamBuilder<ItemsData?>(
              stream: _itemsBloc.itemsDataStream,
              initialData: _itemsBloc.itemsDataStream.valueOrNull,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<String>? items =
                      snapshot.data?.items?.map((e) => e.name ?? "").toList();
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 50),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: MyTheme.dropDownColor,
                          ),
                          child: DropdownSearch<String>(
                            mode: Mode.DIALOG,
                            popupElevation: 0,
                            showSearchBox: true,
                            showSelectedItems: true,
                            items: items,
                            showClearButton: true,
                            popupItemDisabled: (String s) => s.startsWith('I'),
                            onChanged: print,
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                filled: true,
                                fillColor: MyTheme.dropDownColor,
                                hintText: "Search",
                              ),
                            ),
                            dropdownSearchDecoration: InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                              labelText: "select item",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Center(child: Text("error occurred!"));
              },
            );
          },
        ),
      ),
    );
  }
}
