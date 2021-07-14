import 'package:flutter/material.dart';

class Date extends StatelessWidget {
  Date(this.date);

  final DateTime date;

  String toDateString() {
    return date.year.toString() +
        " 年 " +
        date.month.toString() +
        " 月 " +
        date.day.toString() +
        " 日 ";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Text(
        toDateString(),
      ),
    );
  }
}

class Time extends StatelessWidget {
  Time(this.date);

  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return Text(date.hour.toString() + ":" + (date.minute == 0? "00":date.minute.toString()));
  }
}
