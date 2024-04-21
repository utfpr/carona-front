
import 'package:http/http.dart' as http;
class APIPassenger {

  static Future<int> createpasseger(String raceid,String passengerid)async{
    final response=await http.post(Uri.parse("http://localhost:3333/passenger/user/"+passengerid+"/race/"+raceid),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode==201) {
      return 0;
    } else {
      return -1;
    }
  }

  static Future<int> deletepasseger(String passengerid )async{
    final response = await http.delete(
        Uri.parse(
          "http://localhost:3333/"+passengerid
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      return 0;
    } else {
      return -1;
    }
  }
}