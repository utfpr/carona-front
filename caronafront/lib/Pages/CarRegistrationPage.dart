import 'package:caronafront/Pages/CarList.dart';
import 'package:caronafront/Pages/Racepage.dart';

import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../model/Usermoel.dart';

// ignore: must_be_immutable
class CarRegisterPage extends StatefulWidget {
  CarRegisterPage({required User this.user, super.key});
  User user;
  @override
  State<CarRegisterPage> createState() => _CarRegisterPageState();
}

class _CarRegisterPageState extends State<CarRegisterPage> {
  late FocusNode focusplate;
  late TextEditingController controllerplate;
  late String copydescription;
  late String copyplate;
  late FocusNode focusdescription;
  late TextEditingController controllerdescription;
  final _formkey = GlobalKey<FormState>();
  late Future<Car?> car;
  void request() {
    if (focusdescription.hasFocus) {
      focusdescription.requestFocus();
    } else if (focusplate.hasFocus) {
      focusplate.requestFocus();
    }
  }
  
  Future<void> senddatacarbackcreate(
      String plate, String description, String user_id) async {
    final response =
        await APIservicosCar.createcar(plate, description, user_id);
    if (response == -1) {
      ScaffoldMessenger.of(context).showSnackBar(snackbar(
          icon: Icon(Icons.check),
          elevation: 10,
          colorbackgroud: Color.fromARGB(255, 37, 37, 37),
          fontsize: 12,
          color: Colors.white,
          text: "Parabéns! Seu carro foi cadastrado com sucesso!",
          label: "Desfazer",
          onPressed: () {},
          onVisible: null,
          margin: 10));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackbar(
          icon: Icon(Icons.error),
          elevation: 10,
          colorbackgroud: Color.fromARGB(255, 37, 37, 37),
          fontsize: 12,
          color: Colors.white,
          text: "Desculpe-nos, não conseguimos cadastrar",
          label: "Tente Novamente",
          onPressed: () {
            controllerdescription.text = copydescription;
            controllerplate.text = description;
          },
          onVisible: null,
          margin: 10));
    }
  }

   GNav _build_gnav(
      {required Color backgroundColor,
      required Color tabgroundColor,
      required void Function(int) tabchange,
      required double iconsize,
      required int index}) {
    return GNav(
      tabs: const [
        GButton(
          icon: Icons.home_filled,
          text: "Home",
        ),
        GButton(
          icon: Icons.chat_rounded,
          text: "chat",
        ),
        GButton(
          icon: Icons.person_2_outlined,
          text: "profile",
        )
      ],
      selectedIndex: index,
      gap: 8,
      duration: Duration(milliseconds: 900),
      onTabChange: tabchange,
      iconSize: iconsize,
      tabBorderRadius: 25,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      backgroundColor: backgroundColor,
      tabBackgroundColor: tabgroundColor,
    );
  }
  void clear() {
    copyplate = controllerplate.text;
    copydescription = controllerdescription.text;
    controllerplate.clear();
    controllerdescription.clear();
  }

  SnackBar snackbar(
      {required Icon icon,
      required double elevation,
      required Color colorbackgroud,
      required double fontsize,
      required Color color,
      required String text,
      required String label,
      required void Function() onPressed,
      required void Function()? onVisible,
      required double margin}) {
    return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          Text(
            text,
            style: TextStyle(fontSize: fontsize, color: color),
          )
        ],
      ),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: label,
        onPressed: onPressed,
        textColor: color,
      ),
      onVisible: onVisible,
      elevation: elevation,
      backgroundColor: colorbackgroud,
      margin: EdgeInsets.all(margin),
    );
  }

  @override
  void initState() {
    super.initState();
    focusplate = FocusNode();
    controllerplate = TextEditingController();
    controllerdescription = TextEditingController();
    focusdescription = FocusNode();
    focusplate.addListener(request);
    focusdescription.addListener(request);
  }

  @override
  void dispose() {
    super.dispose();
    focusplate.dispose();
    focusdescription.dispose();
  }

  AppBar buildappbar(BuildContext context,
      {required double heightbar,
      required Color color,
      required double radiuscircle,
      required double heightsizebox}) {
    return AppBar(
      leading: IconButton(onPressed:(){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => CarList(user: widget.user,gnav: _build_gnav(
                            backgroundColor: Color.fromARGB(3, 0, 0, 0), 
                            tabgroundColor: Colors.white12, tabchange: (index){
                              if (index==0) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context)=>RacePage(widget.user))
                                  );
                              }
                            }, 
                            iconsize: 20, index: 1),)));
      },icon:Icon(Icons.arrow_back),),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.all(15),
          child: CircleAvatar(
            radius: radiuscircle * MediaQuery.of(context).size.height,
            backgroundColor: Color.fromARGB(221, 51, 39, 153),
          ),
        )
      ],
      toolbarHeight: heightbar * MediaQuery.of(context).size.height,
      backgroundColor: color,
      title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [Text("Olá,"), Text("Caronas rápido e fácil")]),
    );
  }

  TextFormField textform(
      {required double fontsize,
      required Color colorborder,
      required Padding? icon,
      required Color color,
      required double gap,
      required double radius,
      required FocusNode focus,
      required TextEditingController controller,
      required int maxline,
      required String? Function(String?) validate,
      required int maxlegth,
      required String labelhint}) {
    return TextFormField(
      showCursor: false,
      maxLength: maxlegth,
      focusNode: focus,
      controller: controller,
      maxLines: maxline,
      validator: validate,
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: TextStyle(fontSize: fontsize, color: colorborder),
          hintText: labelhint,
          hoverColor: color,
          prefixIcon: icon,
          prefixIconColor: colorborder,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              gapPadding: gap,
              borderSide: BorderSide(
                width: 3,
                color: colorborder,
              )),
          enabledBorder: OutlineInputBorder(
              gapPadding: gap,
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(width: 3, color: colorborder))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildappbar(context,
            heightbar: 0.2,
            radiuscircle: 0.05,
            heightsizebox: 0.01,
            color: Colors.black12),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 25, 290, 0),
              child: Text(
                "Cadastro Carro",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onLongPress: request,
                        child: Container(
                          child: textform(
                              fontsize: 15,
                              colorborder: Colors.white,
                              icon: const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Icon(Icons.car_rental),
                              ),
                              color: Colors.black38,
                              gap: 4,
                              radius: 10,
                              focus: focusplate,
                              controller: controllerplate,
                              maxline: 1,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "nao possvel cadastrar um carro sem placa";
                                }
                              },
                              maxlegth: 7,
                              labelhint: "Placa"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onLongPress: request,
                        child: Container(
                          child: textform(
                              fontsize: 20,
                              colorborder: Colors.white,
                              icon: const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 140),
                                child: Icon(Icons.description_rounded),
                              ),
                              color: Colors.black38,
                              gap: 4,
                              radius: 10,
                              focus: focusdescription,
                              controller: controllerdescription,
                              maxline: 7,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "nao possvel cadastrar um carro sem descriçao";
                                }
                              },
                              maxlegth: 255,
                              labelhint: "Descriçao"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          senddatacarbackcreate(controllerplate.text,
                              controllerdescription.text, widget.user.id);
                        },
                        child: ButtonBarNew(
                            height: 50,
                            fontsize: 20,
                            color: Color(0xFF695E19),
                            title: "Criar Carro"),
                      )
                    ],
                  ),
                )),
          ],
        ));
  }
}
