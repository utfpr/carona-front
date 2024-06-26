import 'package:flutter/material.dart';

class TextinfoHistoryTile extends StatelessWidget {
  TextinfoHistoryTile(
      {required this.info,
      required this.legend,
      required this.container,
      super.key});
  String legend;
  String info;
  Widget container;
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
                  TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.2)),
            ),
            SizedBox(
              width:MediaQuery.of(context).size.width*0.225,
            ),
            container
          ],
        ),
        Text(
          info,
          style: TextStyle(fontSize: 14, color: Colors.white),
        )
      ],
    );
  }
}
