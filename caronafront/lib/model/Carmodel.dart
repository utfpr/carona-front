

class Car{
  String id;
  String plate;
  String description;
  String user;
  DateTime? createdAt;
  DateTime? updateAt;
  Car(this.id,this.plate,this.description,
  this.user,{required DateTime? createdAt,required DateTime? updateAt});

  Map<String, dynamic> tojson(){
    return{
      "id": id ,
      "plate": plate,
      "description": description,
      "createdAt": createdAt ,
      "updateAt": updateAt 
    };
  }
}