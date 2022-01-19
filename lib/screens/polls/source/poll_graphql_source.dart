import 'package:flutter_graphql/graphql/client.dart';
import 'package:flutter_graphql/screens/polls/model/request/get_poll_request.dart';
import 'package:flutter_graphql/screens/polls/model/response/poll_graphql_response.dart';
import 'package:flutter_graphql/screens/polls/source/poll_grahql_request.dart';

class PollGraphQlSource {
  final AppGraphqlClient _client;

  PollGraphQlSource(this._client);

  Stream<PollGraphQlResponse> getPolls(GetPollRequest request) {
    return _client.queryString(PollGraphQulRequest.getPollsQuery, variables: {
      'page': request.page,
      'perPage': 10,
    }).map((response) {
      return PollGraphQlResponse.fromJson(
        response,
        page: request.page,
      );
    });
  }
}
