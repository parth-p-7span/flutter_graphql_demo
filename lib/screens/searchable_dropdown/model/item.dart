class Item {
  String? name;
  String? id;
  String? type;
  String? status;

  /// Indicates if this Item is selected for some group
  /// for example in the products as a product Item
  bool? isSelected;

  Item({
    this.name,
    this.id,
    this.type,
    this.status,
    this.isSelected,
  });

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    return other is Item && other.id == id;
  }
}
