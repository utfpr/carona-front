import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextinfoHistoryTile extends StatelessWidget {
  TextinfoHistoryTile(
      {required this.info,
      required this.legend,
      required this.container,
      required this.width,
      super.key});
  String legend;
  String info;
  Widget container;
  double width;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              legend,
              style:
                  TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.4)),
            ),
            SizedBox(
              width:MediaQuery.of(context).size.width-width-10,
            ),
            container
          ],
        ),
        SizedBox(height: 5,),
        Text(
          info,
          style: TextStyle(fontSize: 14, color: Colors.white),
        )
      ],
    );
  }
}
