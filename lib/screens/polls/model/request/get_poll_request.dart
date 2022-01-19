class GetPollRequest {
  int page;
  int? perPage;

  GetPollRequest({required this.page, this.perPage});

  bool get isInitialRequest => page == 1;
}
