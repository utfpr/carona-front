

class Car{
  String id;
  String plate;
  String modelcolor;
  bool mainCar;
  String user;
  DateTime? createdAt;
  DateTime? updateAt;
  Car(this.id,this.plate,this.modelcolor,this.mainCar,
  this.user,{required DateTime? createdAt,required DateTime? updateAt});

  Map<String, dynamic> tojson(){
    return{
      "id": id ,
      "plate": plate,
      "modelo": modelcolor,
      "createdAt": createdAt ,
      "updateAt": updateAt 
    };
  }
}