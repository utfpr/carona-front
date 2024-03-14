
class User {

  String id;
  String name;
  String email;
  String password;
  DateTime? createdAt;
  DateTime? updateAt;

  User(this.id,this.name,
  this.email,this.password,
  {required DateTime? createdAt,
  required DateTime? updateAt});

  String get_name(){
    return this.name;
  }
  
  Map<String, dynamic> tojson(){
    return {
      "id":id,
      "name":name,
      "password":password,
      "createdAt":createdAt,
      "updateAt":updateAt
    };
  } 
}