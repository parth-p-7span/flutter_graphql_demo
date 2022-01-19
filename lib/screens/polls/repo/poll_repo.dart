import 'package:flutter_graphql/screens/polls/mapper/poll_graphql_response_mapper.dart';
import 'package:flutter_graphql/screens/polls/model/poll_data.dart';
import 'package:flutter_graphql/screens/polls/model/request/get_poll_request.dart';
import 'package:flutter_graphql/screens/polls/source/poll_graphql_source.dart';

class PollRepo {
  final PollGraphQlSource _pollGraphQlSource;
  final PollGraphQlResponseMapper _pollGraphQlResponseMapper;

  PollRepo(this._pollGraphQlSource, this._pollGraphQlResponseMapper);

  ///Get Poll List
  Stream<PollData> getPolls(GetPollRequest request) {
    return _pollGraphQlSource.getPolls(request).map((event) {
      print("--------" + event.polls.toString());
      return _pollGraphQlResponseMapper.map(event);
    });
  }
}
