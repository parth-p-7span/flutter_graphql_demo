class AppliedBadgeFilter {
  String? status;

  AppliedBadgeFilter({this.status});

  Map<String, dynamic> toJson() {
    if (status != null)
      return {
        'status': status ?? null,
      };
    return {'status': status};
  }

  /// Returns true if no filter are applied
  bool get isEmpty => status == null;
}
