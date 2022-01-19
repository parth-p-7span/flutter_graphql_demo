import 'package:flutter_graphql/base/base_mapper.dart';
import 'package:flutter_graphql/screens/polls/model/entity/poll_graphql_entity.dart';
import 'package:flutter_graphql/screens/polls/model/poll.dart';

class PollGraphQlEntityMapper extends BaseMapper<PollGraphQlEntity, Poll> {
  Poll map(PollGraphQlEntity t) {
    return Poll(name: t.name, question: t.question);
  }
}
