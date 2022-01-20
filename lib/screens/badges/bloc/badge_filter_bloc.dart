import 'package:flutter_graphql/base/base_bloc.dart';
import 'package:flutter_graphql/screens/badges/model/response/applied_badge_filter.dart';
import 'package:rxdart/rxdart.dart';

class BadgeFilterBloc extends BaseBloc {
  final selectedStatusStream = BehaviorSubject<String>();

  /// Holds user applied filter
  AppliedBadgeFilter? appliedBadgeFilter;

  /// Business

  BadgeFilterBloc(this.appliedBadgeFilter) {
    if (appliedBadgeFilter != null) {
      selectedStatusStream.add(appliedBadgeFilter?.status ?? "");
    }
    _observeForStatusFilterChange();
  }

  void _observeForStatusFilterChange() {
    subscriptions.add(selectedStatusStream.listen((value) {
      getAppliedFilter()?.status = value;
    }));
  }

  AppliedBadgeFilter? getAppliedFilter() {
    if (appliedBadgeFilter == null) appliedBadgeFilter = AppliedBadgeFilter();
    return appliedBadgeFilter;
  }

  @override
  void dispose() {
    super.dispose();
    selectedStatusStream.close();
  }
}
