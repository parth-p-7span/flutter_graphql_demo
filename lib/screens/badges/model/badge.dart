import 'badge_color.dart';

class Badge {
  String? name;
  String? id;
  String? type;
  String? status;

  /// Indicates if this badge is selected for some group
  /// for example in the products as a product badge
  bool? isSelected;

  Badge({
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
    return other is Badge && other.id == id;
  }
}
