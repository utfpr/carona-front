import 'package:caronafront/Pages/UserPages/AuthUser.dart';
import 'package:caronafront/Pages/PageValidate/Carvalidadate.dart';
import 'package:caronafront/Pages/CarPages/CarHomePage.dart';
import 'package:caronafront/Pages/RacePages/RaceHistoricPage.dart';
import 'package:caronafront/Pages/UserPages/Profile.dart';
import 'package:caronafront/Pages/widget/DrawerAppBar/AppBarCustom.dart';
import 'package:caronafront/Pages/widget/DrawerAppBar/Drawer.dart';
import 'package:caronafront/Pages/widget/Text/TextFormField.dart';
import 'package:caronafront/Pages/widget/Text/Textinfo.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/Pages/widget/Buttons/ButtonBar.dart';
import 'package:caronafront/model/Carmodel.dart';
import '../../model/Usermoel.dart';

// ignore: must_be_immutable
class CarRegisterPage extends StatefulWidget {
  CarRegisterPage(
      {required this.butt, required this.car, required this.user, super.key});
  User user;
  Car? car;
  String butt;
  @override
  State<CarRegisterPage> createState() => _CarRegisterPageState();
}

class _CarRegisterPageState extends State<CarRegisterPage> {
  late TextEditingController controllerplate;
  bool check = true;
  late TextEditingController controllermodelcolor;
  void exit() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => AuthUser()));
  }

  void back(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => CarHomePage(user: widget.user)));
  }

  void update() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Carvalidate(
            user: widget.user,
            back: () {
              Navigator.of(ctx).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => CarHomePage(user: widget.user)));
            },
            tile1: Textinfo(
                info: controllerplate.text, legend: "Nova placa do carro",fontsizeinfo: 14,fontsizelegend: 16,),
            tile2: Textinfo(
                info: controllermodelcolor.text, legend: "Novo Modelo e Cor",fontsizeinfo: 14,fontsizelegend: 16,),
            funct: () => senddatacarbackupdate(
                widget.car!.id,
                controllerplate.text,
                check,
                widget.user.id,
                controllermodelcolor.text,
                ctx),
            buttom: ButtonBarNew(
                color: Colors.yellow,
                title: "Tudo certo !",
                height: 50,
                fontsize: 16))));
  }

  void create() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Carvalidate(
            user: widget.user,
            back: () => back(ctx),
            tile1:
                Textinfo(info: controllerplate.text, legend: "Placa do carro",fontsizeinfo: 14,fontsizelegend: 16,),
            tile2:
                Textinfo(info: controllermodelcolor.text, legend: "Modelo e Cor",fontsizeinfo: 14,fontsizelegend: 16,),
            funct: () => senddatacarbackcreate(controllerplate.text,
                controllermodelcolor.text, widget.user.id, ctx, check),
            buttom: ButtonBarNew(
                color: Colors.yellow,
                title: "Tudo certo!",
                height: 50,
                fontsize: 16))));
  }

  Future<void> senddatacarbackupdate(
      int carid,
      String platenew,
      bool mainCar,
      int userid,
      String descriptionnew,
      BuildContext context) async {
    final response = await APIservicosCar.updatecar(
        carid, mainCar, platenew, userid, descriptionnew);
    if (response == 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Carro atualizado")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Não foi possível  atualizar carro cadastrado")));
    }
    widget.user.havebutton = true;
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => CarHomePage(user: widget.user)));
  }

  Future<void> senddatacarbackcreate(String plate, String description,
      int user_id, BuildContext context, bool check) async {
    final response =
        await APIservicosCar.createcar(plate, description, user_id, check);
    if (response == -1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Carro cadastrado")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Não foi possível  cadastrar carro cadastrado")));
    }
    widget.user.havebutton = true;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => CarRegisterPage(
            car: null, butt: "Criar carro", user: widget.user)));
  }

  @override
  void initState() {
    super.initState();
    controllerplate = (widget.car == null)
        ? TextEditingController()
        : TextEditingController(text: widget.car!.plate);
    controllermodelcolor = (widget.car == null)
        ? TextEditingController()
        : TextEditingController(text: widget.car!.modelcolor);
  }

  @override
  void dispose() {
    super.dispose();
    controllermodelcolor.dispose();
    controllerplate.dispose();
  }

  String? validateplate(String? value) {
    if (value!.length < 7) {
      return "a placa deve ter 7 caracteres";
    }
    return null;
  }

  String? validatemodel(String? value) {
    if (value!.isEmpty) {
      return "Campo Vazio";
    }
    return null;
  }

  void profile() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => Profile(user: widget.user)));
  }

  void carpage() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => CarHomePage(user: widget.user)));
  }

  void historypage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => HistoricHomePage(user: widget.user)));
  }

  @override
  Widget build(BuildContext context) {
    //GlobalKey<FormState> state = GlobalKey<FormState>();
    return Scaffold(
        endDrawer: DrawerCustom(
          user: widget.user,
          carpage: carpage,
          historypage: historypage,
          profile: profile,
        ),
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(0.2 * MediaQuery.of(context).size.height),
            child: AppBarCustom(
              legend: (widget.car==null)?"Criar Carro":"Atualizar Carro",
              user: widget.user,
              height: 0.2 * MediaQuery.of(context).size.height,
              back: ()=>back(context),
              color: Colors.black12,
            )),
        body: Form(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                TextFormFieldTile(
                    leght: 7,
                    value: validateplate,
                    legend: "Placa do carro",
                    hint: "Ex: APP2302",
                    controller: controllerplate),
                SizedBox(
                  height: 13,
                ),
                TextFormFieldTile(
                    leght: 150,
                    value: validatemodel,
                    legend: "Modelo e cor",
                    hint: "Ex: Meriva Vermelho",
                    controller: controllermodelcolor),
                const SizedBox(
                  height: 13,
                ),
                (widget.car != null)
                    ? Row(
                        children: [
                          Checkbox(
                              value: check,
                              onChanged: (value) {
                                setState(() {
                                  check = !check;
                                });
                              }),
                          const Text("Carro Padrão")
                        ],
                      )
                    : Text(""),
                (widget.car == null)
                    ? GestureDetector(
                        onTap: () {
                          create();
                        },
                        child: ButtonBarNew(
                            color: const Color(0xFFFFEB3B),
                            title: widget.butt,
                            height: 50,
                            fontsize: 16),
                      )
                    : GestureDetector(
                        onTap: () {
                          update();
                        },
                        child: ButtonBarNew(
                            color: const Color(0xFFFFEB3B),
                            title: widget.butt,
                            height: 50,
                            fontsize: 16)),
              ],
            ),
          ),
        ));
  }
}
