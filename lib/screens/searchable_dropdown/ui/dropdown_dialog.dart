import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/bloc/items_bloc.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/di/item_module.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/model/item_data.dart';
import 'package:flutter_graphql/theme_data.dart';

class SearchableDropdownDialog extends StatefulWidget {
  const SearchableDropdownDialog({Key? key}) : super(key: key);

  @override
  _SearchableDropdownDialogState createState() =>
      _SearchableDropdownDialogState();
}

class _SearchableDropdownDialogState extends State<SearchableDropdownDialog> {
  late ItemsBloc _itemsBloc;
  String? value;

  @override
  void initState() {
    // TODO: implement initState
    _itemsBloc = ItemModule().getItemsBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyTheme.dropDownColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: TextField(
                    cursorHeight: 20,
                    onChanged: (text) {
                      // _itemsBloc.searchQueryStream.add(text);
                    },
                    decoration: InputDecoration(
                        hintText: "Search", border: InputBorder.none),
                  ),
                ),
              ),
              StreamBuilder<ItemsData?>(
                stream: _itemsBloc.itemsDataStream,
                builder: (context, snapshot) {
                  final items = snapshot.data?.items ?? [];
                  if (items.isEmpty) {
                    return Container(
                        child: Center(child: Text("Data not found")));
                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: ListTile(
                          title: Text(items[index].name ?? ""),
                          tileColor: MyTheme.splashColor,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
