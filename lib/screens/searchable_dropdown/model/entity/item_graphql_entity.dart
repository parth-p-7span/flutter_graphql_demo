class ItemGraphQlEntity {
  String? name;
  String? id;
  String? type;
  String? status;

  ItemGraphQlEntity.fromJson(dynamic json) {
    name = json["name"];
    id = json["id"].toString();
    type = json["type"].toString();
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["id"] = id;
    map["type"] = type;
    map["status"] = status;
    return map;
  }
}
