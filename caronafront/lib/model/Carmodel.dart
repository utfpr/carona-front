

class Car{
  String id;
  String plate;
  String modelo;
  String color;
  String user;
  DateTime? createdAt;
  DateTime? updateAt;
  Car(this.id,this.plate,this.modelo,this.color,
  this.user,{required DateTime? createdAt,required DateTime? updateAt});

  Map<String, dynamic> tojson(){
    return{
      "id": id ,
      "plate": plate,
      "modelo": modelo,
      "createdAt": createdAt ,
      "updateAt": updateAt 
    };
  }
}