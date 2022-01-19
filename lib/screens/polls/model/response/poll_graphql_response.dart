import 'package:flutter_graphql/screens/polls/model/entity/poll_graphql_entity.dart';

class PollGraphQlResponse {
  List<PollGraphQlEntity> polls = [];
  late int page;
  late bool hasMoreData;

  PollGraphQlResponse.fromJson(Map<String, dynamic>? map, {required int page}) {
    polls = [];
    hasMoreData = true;
    final pollJson = map?['polls'];
    // print('----polljson' + pollJson.toString());
    if (pollJson != null) {
      final itemJson = pollJson?['data'];
      print(itemJson.runtimeType.toString());
      if (itemJson != null && itemJson is List) {
        var temp = itemJson.map((e) => PollGraphQlEntity.fromJson(e)).toList();
        polls.addAll(temp);
        print("-----------polls" + polls.toString());
      }
      final paginationJson = pollJson['pagination'];
      if (paginationJson != null)
        hasMoreData = paginationJson['hasMorePages'] ?? true;
    }
    this.page = page;
  }
}
