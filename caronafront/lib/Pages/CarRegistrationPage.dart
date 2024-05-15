import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/Carvalidadate.dart';
import 'package:caronafront/Pages/Profile.dart';
import 'package:caronafront/Pages/widget/TextFormField.dart';
import 'package:caronafront/Pages/widget/Textinfo.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/model/Carmodel.dart';
import '../model/Usermoel.dart';

// ignore: must_be_immutable
class CarRegisterPage extends StatefulWidget {
  CarRegisterPage(
      {required this.butt, 
       required this.car,
       required this.user, 
       super.key});
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
  final _formkey = GlobalKey<FormState>();
  void exit() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => AuthUser()));
  }

  void back() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => Profile(user: widget.user)));
  }

  void update() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Carvalidate(
            user: widget.user,
            back: back,
            tile1: Textinfo(
                info: controllerplate.text, legend: "Nova placa do carro"),
            tile2: Textinfo(
                info: controllermodelcolor.text, legend: "Nova Modelo Cor"),
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
            back: back,
            tile1:
                Textinfo(info: controllerplate.text, legend: "Placa do carro"),
            tile2:
                Textinfo(info: controllermodelcolor.text, legend: "Modelo Cor"),
            funct: () => senddatacarbackcreate(controllerplate.text,
                controllermodelcolor.text, widget.user.id, ctx, check),
            buttom: ButtonBarNew(
                color: Colors.yellow,
                title: "Tudo certo!",
                height: 50,
                fontsize: 16))));
  }

  Future<void> senddatacarbackupdate(
      String carid,
      String platenew,
      bool mainCar,
      String userid,
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
    setState(() {
      widget.user.havebutton=true;
    });
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => Profile(user: widget.user)));
  }

  Future<void> senddatacarbackcreate(String plate, String description,
      String user_id, BuildContext context, bool check) async {
    final response =
        await APIservicosCar.createcar(plate, description, user_id, check);
    if (response == -1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Carro cadastrado")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Não foi possível  cadastrar carro cadastrado")));
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => CarRegisterPage(
            car: null, butt: "Criar carro", user: widget.user)));
  }

  void clear() {
    controllerplate.clear();
    controllermodelcolor.clear();
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

  AppBar _buildappbar(
    BuildContext context, {
    required double heightbar,
    required Color color,
    required double radiuscircle,
    required double heightsizebox,
  }) {
    return AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: back,
        ),
        toolbarHeight: heightbar * MediaQuery.of(context).size.height,
        backgroundColor: color,
        title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Olá, ${widget.user.name}",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Criar um carro",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ])
            ]));
  }

  Widget? drawer() {
    return Drawer(
        width: 0.5 * MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, 0, 0, MediaQuery.of(context).size.height - 500),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.person_2_outlined),
                          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                        ),
                        Text("Meu perfil")
                      ],
                    ))),
            Expanded(
                child: ListView(
              reverse: true,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  onTap: exit,
                  title: const Text(
                    "Sair",
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: drawer(),
        appBar: _buildappbar(context,
            heightbar: 0.2,
            radiuscircle: 0.05,
            heightsizebox: 0.01,
            color: Colors.black12),
        body: ListView(
          shrinkWrap: true,
          children: [
            Form(
                key: _formkey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormFieldTile(
                          leght: 7,
                          legend: "Qual é a placa do carro?",
                          hint: "Ex: APP2302",
                          controller: controllerplate),
                      TextFormFieldTile(
                          leght: 150,
                          legend: "Qual modelo e cor do carro ?",
                          hint: "Ex: Meriva 2010",
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
                              onTap: create,
                              child: ButtonBarNew(
                                  color: const Color(0xFFFFEB3B),
                                  title: widget.butt,
                                  height: 50,
                                  fontsize: 16),
                            )
                          : GestureDetector(
                              onTap: update,
                              child: ButtonBarNew(
                                  color: const Color(0xFFFFEB3B),
                                  title: widget.butt,
                                  height: 50,
                                  fontsize: 16)),
                    ],
                  ),
                )),
          ],
        ));
  }
}
