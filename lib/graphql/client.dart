import 'package:flutter_graphql/base/app_exception.dart';
import 'package:flutter_graphql/session/helper/session_expiration_helper.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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
      print('//// Data: ${result.data?.toString()}');
      if (result.exception != null) {
        throw AppException(message: _getErrorMessage(result.exception, true));
      }
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
      if (result.exception != null) {
        throw AppException(message: _getErrorMessage(result.exception, false));
      }
      return result.data;
    });
  }

  String? _getErrorMessage(OperationException? exception, bool isQuery) {
    if (exception?.linkException != null) {
      final error = exception?.linkException;
      String errorMessage =
          exception?.linkException?.originalException.toString() ?? "error";
      if (errorMessage.contains('User not found') ||
          errorMessage.contains('Token expired') ||
          errorMessage.contains('Invalid token')) {
        SessionExpirationHelper().sessionExpirationStream.add(true);
      }
      if (error is NetworkException &&
          error.originalException is SocketException) {
        return 'Connectivity issue, Please try again.';
      }
    }
    if (exception?.graphqlErrors.isNotEmpty == true) {
      final message = exception?.graphqlErrors[0].message;

      return message;
    }

    return isQuery
        ? 'Failed to load data, try again'
        : 'Failed to update data, try again';
  }
}
