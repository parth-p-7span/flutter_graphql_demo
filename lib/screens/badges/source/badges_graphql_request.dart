class BadgesGraphQlRequests {
  static String badgesQuery = r'''
    query GetTags($businessId: Int!, $page: Int, $search:String, $limit: Int, $filters: TagFilter) {
 tags(page:$page,perPage:$limit,filters:$filters,campaignId:$businessId, search:$search){
  data{
    id
  	name
    status
    type
  }	
  pagination{
    total
    hasMorePages
  }
}
}
  ''';
}
