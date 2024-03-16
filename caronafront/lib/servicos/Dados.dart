import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';

class AuthenticationUser {
  static Future<User?> auth(String id)async{
    final user=await APIservicosUser.fectchuser(id);
    return user;
  }
}