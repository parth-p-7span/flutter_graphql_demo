import 'package:flutter_graphql/main_dev.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:io';

class AppGraphqlClient {
  GraphQLClient? _client;

  AppGraphqlClient(
    String graphQlUrl,
  ) {
    final httpLink = HttpLink(
      graphQlUrl,
    );

    _client = GraphQLClient(
      cache: GraphQLCache(),
      defaultPolicies: DefaultPolicies(
        query: Policies(
          fetch: FetchPolicy.noCache,
        ),
        watchQuery: Policies(
          fetch: FetchPolicy.noCache,
        ),
      ),
      link: httpLink,
    );
  }

  /// Perform query
  Stream<Map<String, dynamic>?> query(QueryOptions options) {
    return _client!.query(options).asStream().map((result) {
      print('//// exception: ${result.exception?.toString()}');
      return result.data;
    });
  }

  /// Perform query by passing query string.
  Stream<Map<String, dynamic>?> queryString(String query,
      {required Map<String, dynamic> variables}) {
    return _client!
        .query(QueryOptions(document: gql(query), variables: variables))
        .asStream()
        .map((result) {
      print('//// exception: ${result.exception?.toString()}');
      return result.data; //.data;
    });
  }

  /// Perform mutation
  Stream<Map<String, dynamic>?> mutate(MutationOptions options) {
    return _client!.mutate(options).asStream().map((result) {
      print('//// exception: ${result.exception?.toString()}');
      return result.data;
    });
  }

  /// Perform mutation by passing query string
  Stream<Map<String, dynamic>?> mutateString(String query,
      {required Map<String, dynamic> variables}) {
    return _client!
        .mutate(MutationOptions(document: gql(query), variables: variables))
        .asStream()
        .map((result) {
      print('//// exception: ${result.exception?.toString()}');
      return result.data;
    });
  }
}
