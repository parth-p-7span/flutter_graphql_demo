import 'package:flutter_graphql/graphql/client.dart';
import 'package:flutter_graphql/helper/shared_preference_manager.dart';

class AppModule {
  static final _instance = AppModule._internal();
  AppModule._internal();

  factory AppModule() {
    return _instance;
  }

  final sharedPreferenceManager = SharedPreferenceManager();

  late AppGraphqlClient graphqlClient;
}
