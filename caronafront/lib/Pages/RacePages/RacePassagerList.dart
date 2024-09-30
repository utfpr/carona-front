
import 'package:caronafront/Pages/widget/Tile/PassagerTile.dart';
import 'package:caronafront/model/PassagerModel.dart';
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class PassagerList extends StatefulWidget {
  PassagerList(this.passagers,{super.key});
  List<Passager>?passagers;
  @override
  State<PassagerList> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PassagerList> {
  AppBar _buildappbar(BuildContext context,
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
              backgroundColor: const Color.fromARGB(221, 51, 39, 153),
            ),
          )
        ],
        toolbarHeight: heightbar * MediaQuery.of(context).size.height,
        backgroundColor: color,
        title: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Passageiros"),
            ]));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold (
    appBar:_buildappbar(context,
            heightbar: 0.2,
            radiuscircle: 0.05,
            heightsizebox: 0.01,
            color: Colors.black12,),
    body:CustomScrollView(slivers: [
      SliverList(
      delegate: SliverChildBuilderDelegate(
      childCount:widget.passagers!.length ,
      (ctx,index){
          return PassgerTitle(widget.passagers!.elementAt(index));
      })
      )
    ],)
    );
  }
}