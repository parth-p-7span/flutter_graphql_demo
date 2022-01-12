class UserGraphQlEntity {
  String? id;
  String? uuid;
  String? name;
  String? email;

  UserGraphQlEntity.fromJson(Map<String, dynamic> map) {
    id = map['id']?.toString();
    uuid = map['uuid'];
    name = map['name'];
    email = map['email'];
  }
}
