import 'package:flutter_graphql/screens/polls/model/poll.dart';

class PollData {
  List<Poll>? polls;
  int currentPage;
  bool? isEndReached;

  PollData({this.polls, required this.currentPage, this.isEndReached = false});

  PollData copyWith({List<Poll>? polls, int? currentPage, bool? isEndReached}) {
    return PollData(
      polls: polls ?? this.polls,
      isEndReached: isEndReached ?? this.isEndReached,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  bool get isInitialData => currentPage == 1;
}
