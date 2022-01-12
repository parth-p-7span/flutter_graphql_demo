class ContinentGraphqlRequest {
  static String continentsQuery = r"""
  query{
  continents{
    code
    name
  }
}
  """;
}
