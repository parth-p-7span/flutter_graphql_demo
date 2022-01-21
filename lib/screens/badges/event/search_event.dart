import 'package:flutter_graphql/base/base_event.dart';

class SearchEvent extends BaseEvent<String> {
  SearchEvent(String query) : super(data: query);
}
