import 'package:flutter_graphql/graphql/client.dart';

class AppModule {
  static final _instance = AppModule._internal();
  AppModule._internal();

  factory AppModule() {
    return _instance;
  }

  late AppGraphqlClient graphqlClient;
}
