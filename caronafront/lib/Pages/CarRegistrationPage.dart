import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/Profile.dart';
import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/Pages/widget/TextFormField.dart';

import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/model/Carmodel.dart';
import '../model/Usermoel.dart';

// ignore: must_be_immutable
class CarRegisterPage extends StatefulWidget {
  CarRegisterPage({required String this.butt,required Car? this.car,required User this.user, super.key});
  User user;
  Car? car;
  String butt;
  @override
  State<CarRegisterPage> createState() => _CarRegisterPageState();
}

class _CarRegisterPageState extends State<CarRegisterPage> {
  late TextEditingController controllerplate;
  late FocusNode focusdescription;
  late TextEditingController controllerdescription;
  final _formkey = GlobalKey<FormState>();
  late Future<Car?> car;
  void exit(){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AuthUser()));
  }
  void back(){
    Navigator.of(context).pop();
  }
  Future<void> senddatacarbackcreate(
      String plate, String description, String user_id,int quantidade) async {
    final response =
        await APIservicosCar.createcar(plate, description, user_id,quantidade);
    if (response == -1) {
    } else {
    }
  }
  void clear() {
    controllerplate.clear();
    controllerdescription.clear();
  }
  @override
  void initState() {
    super.initState();
    controllerplate =(widget.car==null)?TextEditingController():TextEditingController(text:widget.car!.plate);
    controllerdescription = (widget.car==null)?TextEditingController():TextEditingController(text:widget.car!.description);
  }

  @override
  void dispose() {
    super.dispose();
    controllerdescription.dispose();
    controllerplate.dispose();
  }

  AppBar _buildappbar(BuildContext context,
      {required double heightbar,
      required Color color,
      required double radiuscircle,
      required double heightsizebox,}) {
    return AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,),onPressed: back,),
        toolbarHeight: heightbar * MediaQuery.of(context).size.height,
        backgroundColor: color,
        title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Olá, ${widget.user.name}",style: TextStyle(color: Colors.white,fontSize:15),),
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Criar um carro",style: TextStyle(fontSize: 20,color: Colors.white),),
                  ])
            ]));
  }

  Widget ? drawer(){
    return Drawer(
            width: 0.5*MediaQuery.of(context).size.width,
            child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Expanded(child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height-500),
                  child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Icon(Icons.person_2_outlined),
                  backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                ),Text("Meu perfil")
              ],
            )  ) ),
            Expanded(child: ListView(
          reverse: true,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
              ListTile(
                onTap: exit,
                title: Text("Sair",style:TextStyle(fontSize: 15),),
              )
          ],
        )
        )
        ],
        )
        );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: drawer() ,
        appBar: _buildappbar(context,
            heightbar: 0.2,
            radiuscircle: 0.05,
            heightsizebox: 0.01,
            color: Colors.black12),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormFieldTile(leght: 7, legend: "Qual é a placa do carro?", hint: "Ex: APP2302", controller:controllerplate),
                      TextFormFieldTile(leght: 150, legend: "Qual a descrição?", hint: "Ex: Meriva 2010 Prata", controller: controllerdescription),
                      SizedBox(height: 13,),
                      ButtonBarNew(color: Color(0xFFFFEB3B), title: widget.butt, height: 50, fontsize: 16)
                    ],
                  ),
                )),
          ],
        ));
  }
}
