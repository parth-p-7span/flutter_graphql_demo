class CountryGraphQlEntity {
  String? code;
  String? name;
  String? phone;
  String? capital;
  String? currency;

  CountryGraphQlEntity.fromJson(Map<String, dynamic> map) {
    code = map['code'];
    name = map['name'];
    phone = map['phone'];
    capital = map['capital'];
    currency = map['currency'];
  }
}
