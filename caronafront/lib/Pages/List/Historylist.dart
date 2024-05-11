import 'package:caronafront/Pages/widget/HistoryTile.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  HistoryList({required this.user, super.key});
  User user;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) => Padding(
                  padding: EdgeInsets.all(16),
                  child: HistoryTile(
                  user,
                  Race("", "UTF", "Girafas", user, "", "12/02/2001", [], 3,
                      createdAt: null, updateAt: null),
                ))))
      ],
    );
  }
}
