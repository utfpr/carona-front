import 'package:caronafront/servicos/Dados.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
class CarRegisterPage extends StatefulWidget {
  const CarRegisterPage({super.key});

  @override
  State<CarRegisterPage> createState() => _CarRegisterPageState();
}

class _CarRegisterPageState extends State<CarRegisterPage> {
  late FocusNode focusplate;
  late TextEditingController controllerplate;
  late FocusNode focusdescription;
  late TextEditingController controllerdescription;
  final _formkey=GlobalKey<FormState>();
  final snack_bar_error=SnackBar(content: content)
  void request(){
    if (focusdescription.hasFocus) {
      focusdescription.requestFocus();
    }else if(focusplate.hasFocus){
      focusplate.requestFocus();
    }
  }
  @override
  void initState() {
    super.initState();
    focusplate=FocusNode();
    controllerplate=TextEditingController();
    controllerdescription=TextEditingController();
    focusdescription=FocusNode();
    focusplate.addListener(request);
    focusdescription.addListener(request);
  }
  @override
  void dispose() {
    super.dispose();
    focusplate.dispose();
    controllerplate.dispose();
  }
  AppBar buildappbar(BuildContext context,AuthenticationUser user,{required double heightbar,required Color color, 
  required double radiuscircle,required double heightsizebox}){
    return AppBar(
    actions: [
      Padding(padding:const EdgeInsetsDirectional.all(15) ,
      child:CircleAvatar(radius: radiuscircle*MediaQuery.of(context).size.height,backgroundColor:Color.fromARGB(221, 51, 39, 153) ,),)],
    toolbarHeight: heightbar*MediaQuery.of(context).size.height,
    backgroundColor: color,
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center, 
      mainAxisSize: MainAxisSize.min,
      children: [
      Text("Olá, ${AuthenticationUser.get_user().name}"),
      Text("Caronas rápido e fácil")
    ]),);
  }

  TextFormField textform({required double fontsize,required Color colorborder,required Padding? icon,required Color color,
  required double gap, required double radius,required FocusNode focus,
  required TextEditingController controller,required int maxline,
  required String? Function(String?)validate,required int maxlegth,required String labelhint}){
    return TextFormField(
      showCursor: false,
      maxLength: maxlegth,
      focusNode: focus,
      controller:controller,
      maxLines: maxline,
      validator:validate ,
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
          fontSize: fontsize,
          color: colorborder
        ),
        hintText:labelhint ,
        hoverColor: color,
        prefixIcon:icon ,
        prefixIconColor: colorborder,
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius),
        gapPadding: gap,borderSide:BorderSide(
          width: 3,
          color: colorborder,
        )) ,
        enabledBorder: OutlineInputBorder(gapPadding:gap,
        borderRadius: BorderRadius.circular(radius),borderSide:  BorderSide(
          width: 3,
          color: colorborder
        ) )
      ),
    );
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
      key: _formkey,
      child:Padding(padding: const EdgeInsets.all(32),
      child: Column(
        children:<Widget> [
          GestureDetector(
            onLongPress: request,
            child:Container(
            child: textform(
              fontsize: 15,
              colorborder: Colors.white,icon:const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),child: Icon(Icons.car_rental),), color: Colors.black38, 
              gap: 4, radius: 10, 
              focus: focusplate, controller: controllerplate, 
              maxline: 1, 
            validate: (value){
              if(value!.isEmpty){
                return "nao possvel cadastrar um carro sem placa";
              }
            }, 
            maxlegth:10 , labelhint:"Placa"),
            ),
          ),const SizedBox(height: 10,),
          GestureDetector(
            onLongPress: request,
            child: Container(
            child: textform(
            fontsize: 20,
            colorborder: Colors.white,icon: const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 140),
            child: Icon(Icons.description_rounded),) , color: Colors.black38, 
            gap: 4, radius: 10, 
            focus: focusdescription, controller: controllerdescription, 
            maxline: 7, 
            validate: (value){
              if(value!.isEmpty){
                return "nao possvel cadastrar um carro sem descriçao";
              }
            }, 
            maxlegth: 255, labelhint:"Descriçao"),
          ),
          ),const SizedBox(height: 10,),
          GestureDetector(
            child: ButtonBarNew(
            height: 50,fontsize: 15,
            color:Colors.yellow,
            title: "Criar Carro"
          )   ,
          )     
        ],),
        )
      ),
    );
  }
}