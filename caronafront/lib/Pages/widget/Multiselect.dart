import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';

import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:provider/provider.dart';

class MultidropdownCustom extends StatefulWidget {
  MultidropdownCustom(
    {required this.onsave,required this.title,
      required this.okbutton,
      required this.cancelbutton,
      required this.legend,
      required this.race,
      super.key});
  final String title;
  final Race? race;
  final String legend;
  final String okbutton;
  final String cancelbutton;
  List<dynamic> actives = [];
  final void Function(dynamic) onsave;
  @override
  State<MultidropdownCustom> createState() => _MultidropdownCustomState();

}

class _MultidropdownCustomState extends State<MultidropdownCustom> {
  List<User> listuser = [];
  List<dynamic> listdata=[];
  Future<List<User>> getlistuser() async {
    for (var i = 0; i < widget.race!.passenger.length; i++) {
      final reponse = await APIservicosUser.fectchuser(
          widget.race!.passenger.elementAt(i).userId);
      listuser.add(reponse);
    }
    return listuser;
  }
  void getdatasource()async{
    List<User>list=await getlist();
    for (var i = 0; i < widget.race!.passenger.length; i++) {
      listdata.add({
        "display":list.elementAt(i).name,
        "value":widget.race!.passenger.elementAt(i).id
      });
    }
  }
  Future<List<User>> getlist()async{
    return await getlistuser();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdatasource();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(widget.title),
          MultiSelectFormField(
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            trailing: Icon(Icons.arrow_drop_down, color: Colors.white,),
            textField: 'display',
            valueField: 'value',
            title: Text(
              "",
              style: TextStyle(fontSize: 14),
            ),
            hintWidget: Text(widget.legend),
            fillColor: Colors.black12,
            okButtonLabel: widget.okbutton,
            cancelButtonLabel: widget.cancelbutton,
            initialValue: widget.actives,
            onSaved:widget.onsave,
            dataSource:listdata)
        ],);
  }
}
