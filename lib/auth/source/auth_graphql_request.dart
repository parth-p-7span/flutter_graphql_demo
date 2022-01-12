class AuthGraphQlRequests {
  static String signUpQuery = r''' 
   mutation signup($name: String, $email: String, $password: String) {
   signup(input: {name: $name,email: $email,password: $password}) {
        token
          user{
            id
            name
            email
            uuid
          }  
      }
     }
  ''';
}
