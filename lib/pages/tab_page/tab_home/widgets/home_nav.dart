import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkeeping/routes/routes.dart';

class HomeNav extends StatelessWidget {
  const HomeNav({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0xfff2f2f2), blurRadius: 0.1)],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => {Get.toNamed(AppRoutes.Account)},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.assignment_rounded, size: 32),
                  Text('账单')
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => {Get.toNamed(AppRoutes.Timeline)},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.timeline, size: 32),
                  Text('时间线')
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => {Get.toNamed(AppRoutes.Timeline)},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.verified_user_rounded, size: 32),
                  Text('资产管理')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
