import 'package:flutter/material.dart';

class DropDownTile<T> extends StatelessWidget {
  DropDownTile(
      {required this.value,
      required this.legend,
      required this.list,
      required this.onChanged,
      super.key});
  void Function(dynamic) onChanged;
  T value;
  String legend;
  List<DropdownMenuItem<T>> list;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(legend),
        SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(10)),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(10))),
            value: value,
          items: list,
          onChanged: onChanged,
        )
      ],
    );
  }
}
