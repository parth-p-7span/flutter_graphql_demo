import 'package:flutter_graphql/base/base_mapper.dart';
import 'package:flutter_graphql/screens/polls/mapper/poll_graphql_entity_mapper.dart';
import 'package:flutter_graphql/screens/polls/model/poll_data.dart';
import 'package:flutter_graphql/screens/polls/model/response/poll_graphql_response.dart';

class PollGraphQlResponseMapper
    extends BaseMapper<PollGraphQlResponse, PollData> {
  final _pollGraphQlEntityMapper = PollGraphQlEntityMapper();

  PollData map(PollGraphQlResponse t) {
    // print("--------t : " + t.polls.toString());
    return PollData(
        isEndReached: !t.hasMoreData,
        currentPage: t.page,
        polls: t.polls.map((e) => _pollGraphQlEntityMapper.map(e)).toList());
  }
}
