class PollGraphQulRequest {
  static String getPollsQuery = r'''
  query GetPolls($page:Int, $perPage:Int){
  polls(perPage: $perPage,page:$page){
    data{
      name
      question
    }
    pagination{
      total
      hasMorePages
    }
  }
}
  ''';
}
