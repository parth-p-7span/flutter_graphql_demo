class PollGraphQlEntity {
  String? name;
  String? question;

  PollGraphQlEntity.fromJson(Map<String, dynamic> map) {
    name = map['name'];
    question = map['question'];
  }
}
