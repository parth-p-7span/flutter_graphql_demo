class CountryGraphQlRequest {
  static String countriesQuery = r'''
  query getCountries($code:ID!){
  continent(code:$code){
    countries{
      code
      name
      phone
      capital
      currency
    }
  }
}
  ''';
}
