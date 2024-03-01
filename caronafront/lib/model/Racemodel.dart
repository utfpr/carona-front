// ignore: file_names
class Race{
  final String id;
  final String endpoint;
  final String originpoint;
  final String carid;
  final DateTime timestart;
  final DateTime createdAt;
  final DateTime updateAt;
  const Race(this.carid,this.endpoint,this.originpoint,this.id, 
  {required this.timestart, required this.updateAt,required this.createdAt});
  Race.fromJson(Map<String, dynamic> json)
      : endpoint = json['endpoint'] as String,
        originpoint = json['originpoint'] as String,
        carid=json['carid'] as String,
        id=json['id'],
        timestart=json['timestart'],
        createdAt=json['createdAt'],
        updateAt=json['updateAt']
        ;
  Map<String,dynamic>tojson()=>{
    'originpoint':originpoint,
    'endpoint':endpoint,
    'carid':carid,
  };
}