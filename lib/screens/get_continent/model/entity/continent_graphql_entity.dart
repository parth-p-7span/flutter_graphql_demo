class ContinentGraphqlEntity{
  String? code;
  String? name;

  ContinentGraphqlEntity.fromJson(Map<String,dynamic> map){
    code = map['code'];
    name = map['name'];
  }
}