
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/model/Usermoel.dart';
class PassagerList extends StatefulWidget {
  PassagerList(this.passagers,{super.key});
  List<User>passagers;
  @override
  State<PassagerList> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PassagerList> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
       SliverList(
      delegate: SliverChildBuilderDelegate(
      childCount:widget.passagers.length ,
      (ctx,index){
          return GestureDetector(
          child: ListTile(
            title: Text(widget.passagers.elementAt(index).name),
            subtitle:Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.passagers.elementAt(index).email),
              ],
            ),
            trailing: IconButton(
              onPressed: ()async{
                final response=await APIservicosUser.deleteuser(widget.passagers.elementAt(index).id);
              },icon: Icon(Icons.delete),
            ),
          ),
        );
      })
      )
    ],);
  }
}