import 'item.dart';

class ItemsData {
  List<Item>? items;

  ItemsData({this.items});

  ItemsData copyWith(
      {List<Item>? items}) {
    return ItemsData(items: items ?? this.items);
  }
}
