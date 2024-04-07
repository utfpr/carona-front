import 'package:caronafront/Pages/CarRegistrationPage.dart';
import 'package:caronafront/Pages/widget/Cartitle.dart';
import 'package:caronafront/model/Provider/UpdateProvider.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CarList extends StatefulWidget {
  CarList({super.key, required this.user,required this.gnav});
  User user;
  GNav gnav;
  int count_car=0;
  late UpdateProviderCar car;
  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  late UpdateProviderCar update;
  late GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    update=UpdateProviderCar();
    APIservicosCar.getallcar(widget.user.id).then((value) {
      setState(() {
        update.car_value=value;
        widget.count_car=update.car_value!.length;
      });
    }); 
    refreshIndicatorKey=GlobalKey<RefreshIndicatorState>();
  }
  Future<Null> refresh()async{
    await Future.delayed(Duration(seconds: 2));
    update.car_value=await APIservicosCar.getallcar(widget.user.id);
    return null;
  }
  Column mgsnogetall(String msg) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          msg,
          style: TextStyle(color: Colors.white.withOpacity(0.1), fontSize: 12),
        ),
        SizedBox(
          child: Icon(
            Icons.car_crash,
            size: 100,
            color: Colors.white.withOpacity(0.1),
          ),
          width: 100,
          height: 100,
        )
      ],
    );
  }

  AppBar buildappbar(BuildContext context,
      {required double heightbar,
      required Color color,
      required double radiuscircle,
      required double heightsizebox}) {
    return AppBar(
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
      title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
          Text("${widget.user.name}",style: TextStyle(fontSize: 20),),
          Text("Quantidade Carro: ${widget.count_car}",style: TextStyle(fontSize: 10),) 
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final msgnotfoundcar = Center(
      child: mgsnogetall("Nao encontrado carros"),
    );
    return Scaffold(
      appBar: buildappbar(
        context,
        heightbar: 0.2,
        radiuscircle: 0.05,
        heightsizebox: 0.01,
        color:const Color.fromARGB(3, 71, 71, 71),
      ),
      body: (update.car_value==null)?
      msgnotfoundcar:RefreshIndicator(
        key: refreshIndicatorKey,
        // ignore: sort_child_properties_last
        child:ListView.builder(
        itemCount: update.car_value!.length,
        itemBuilder: (ctx,index){
          return CarTitle(car:update.car_value!.elementAt(index));
        })
      ,onRefresh:refresh),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(180)),
        backgroundColor: Color(0xFF695E19),
        hoverColor: Color(0xFF695E19),
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => CarRegisterPage(user: widget.user)));             
        },
       child: Icon(Icons.add),       
      ),
      bottomNavigationBar: widget.gnav,
    );
  }
}
