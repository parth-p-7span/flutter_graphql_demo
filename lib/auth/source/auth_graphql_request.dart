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

  static String loginQuery = r''' 
   mutation login($email:String,$password:String){
  login(input:{email:$email,password:$password}){
    token
    user{
      id
      uuid
      name
      email
    }
  }
}	
  ''';
}
