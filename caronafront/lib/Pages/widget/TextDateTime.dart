import 'package:adoptive_calendar/adoptive_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TextDateTime extends StatelessWidget {
  TextDateTime(
      {required this.date,
      required this.legend,
      required this.onTap,
      super.key});
  DateTime date;
  String legend;
  Future<Null> Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:MainAxisAlignment.start,
      children: [
        Text(legend),
        SizedBox(height: 10,),
        TextField(
          decoration: InputDecoration(
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(10),
          ),enabledBorder:OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(10),
          ),border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(10),
          )  
          ),
          onTap: onTap,
          readOnly: true,
          controller: TextEditingController(
              text: DateFormat("dd/MM/yyyy HH:mm").format(date),
        )
        )
      ],
    );
  }
}
