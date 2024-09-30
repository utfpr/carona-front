import 'package:caronafront/Pages/CarPages/CarHomePage.dart';
import 'package:caronafront/Pages/RacePages/RaceHistoricPage.dart';
import 'package:caronafront/Pages/RacePages/Racepage.dart';
import 'package:caronafront/Pages/widget/DrawerAppBar/AppBarCustom.dart';
import 'package:caronafront/Pages/widget/DrawerAppBar/Drawer.dart';
import 'package:caronafront/Pages/widget/Text/Textinfo.dart';
import 'package:caronafront/Pages/UserPages/EditUser.dart';
import 'package:caronafront/Provider/UpadateRace.dart';
import 'package:caronafront/Provider/UpdateProviderCar.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/* 
 * Nome: Guilherme Almeida Lopes
 * Data criação e Atualização: 13/09/2024
 * GitHub:alguiguilo098 
*/
class Profile extends StatelessWidget {
  const Profile({required this.user, super.key});
  final User user;// usuário autenticado no sisitema
  void carpage(BuildContext context) {// vai para a tela de carros cadastrado pelo user 
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => CarHomePage(user: user)));
  }

  void historypage(BuildContext context) {// vai para a tela de histórico de corridas
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => HistoricHomePage(user: user)));
  }

  void back(BuildContext context) {// volta para home page 
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => HomePage(user)));
  }

  void edituser(BuildContext context) { // tela para editar os dados do usuários
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => EditUser(user: user)));
  }

  @override
  Widget build(BuildContext context) {
    final providercar=Provider.of<UpdateProviderCar>(context);// gerenciador de estado dos carros 
    final providerrace=Provider.of<UpadateRace>(context); // gerenciador de estado das corridas
    //GlobalKey<ScaffoldState> key=GlobalKey<ScaffoldState>();
    providercar.getcarlist(user.id); // get a lista dos carros do usuário
    providerrace.getracepeding(user.id); // get corridas pedentes
    final query=MediaQuery.of(context).size; 
    return Scaffold(
        endDrawer: DrawerCustom(
          user: user,
          profile: () {},// estamos na pagina profile, não podemos acessaar a rota para a pagina que estamos 
          carpage: () => carpage(context),// pagina de corridas
          historypage: () => historypage(context), // históricos 
        ),
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(0.2 * MediaQuery.of(context).size.height),
            child: AppBarCustom(
              legend: "Perfil",
              user: user,
              height: 0.2 * query.height,// 20% do altura da tela
              back: () => back(context),
              color: Colors.black12,
            )),
        body:   Padding(padding:const EdgeInsets.symmetric(horizontal: 50),child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Textinfo(info: user.name, legend: "Nome",fontsizeinfo: 14,fontsizelegend: 16,),//mostra o nome do usuário
            const SizedBox(
              height: 40,
            ),
            Textinfo(info: user.email, legend: "E-mail",fontsizeinfo: 14,fontsizelegend: 16,),// mostra o email do usuário
            const SizedBox(
              height: 40,
            ),
            Textinfo(info: user.ra, legend: "RA",fontsizeinfo: 14,fontsizelegend: 16,),// mostra o RA do usuário
            const SizedBox(
              height: 40,
            ),
            Textinfo(info: providercar.listcar.length.toString(), legend: "Carros cadastrados",fontsizeinfo: 14,fontsizelegend: 16,), // a quantidade carros cadastrados
            const SizedBox(
              height: 10,
            ),
          ],
        )),floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal:0.025*query.width,vertical: 0.05*query.height),
          child: FloatingActionButton(
            backgroundColor: Colors.yellow,
            onPressed:()=> edituser(context),// vai  para tela de atualizar dados de usuário
            child:const Icon(
              Icons.edit,
              color: Colors.black,
            )),
        ),
        );
  }
}
