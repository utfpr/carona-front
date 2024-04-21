import 'package:caronafront/model/Racemodel.dart';
import 'package:flutter/material.dart';

class RaceList extends StatefulWidget {
  RaceList({List<Race>? race,super.key});
  List<Race>? race;
  @override
  State<RaceList> createState() => _RaceListState();
}

class _RaceListState extends State<RaceList> {
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
            Icons.clear_rounded,
            size: 100,
            color: Colors.white.withOpacity(0.1),
          ),
          width: 100,
          height: 200,
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    final msgnofound = Center(child: mgsnogetall("Nao encontrado corridas"));
    return Scaffold(
      body: (widget.race==null)?SliverList(
      delegate: SliverChildBuilderDelegate(
      (ctx,index){
        return GestureDetector(
          child: ListTile(
            title: Text(widget.race!.elementAt(index).originpoint),
            subtitle:Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.race!.elementAt(index).endpoint),
                Text(widget.race!.elementAt(index).timestart)
              ],
            ),
            trailing: IconButton(
              onPressed: (){
                
              },icon: Icon(Icons.delete),
            ),
          ),
        );
      })
      ):msgnofound
    );
  }
}