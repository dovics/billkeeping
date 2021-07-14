import 'package:billkeeping/pages/tab_page/tab_chart/widget/bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkeeping/pages/tab_page/tab_chart/widget/pie.dart';

class TabChartPage extends StatelessWidget {
  final _type = 'month'.obs;
  final _list = [
    {'title': '周', 'key': 'week'},
    {'title': '月', 'key': 'month'},
    {'title': '年', 'key': 'year'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '统计信息',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(36),
            child: Container(
              height: 36,
              margin: EdgeInsets.only(bottom: 10, left: 60, right: 60),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: Row(
                children: _list
                    .map((e) => Expanded(
                          child: buildGestureDetector(
                              context, e['title'], e['key']),
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
        body: Container(
          color: Color(0xF4F4F4),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                padding: EdgeInsets.all(10),
                height: 175,
                child: Obx(() => PieChart.withData(_type.value)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xffE2E2E2),
                          offset: Offset(2.0, 2.0),
                          blurRadius: 10.0)
                    ]),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                height: 250,
                child: Obx(() => BarChart.withData(_type.value)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xffE2E2E2),
                          offset: Offset(2.0, 2.0),
                          blurRadius: 10.0)
                    ]),
              ),
            ],
          ),
        ));
  }

  GestureDetector buildGestureDetector(
      BuildContext context, String title, String key) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _type.value = key,
      child: Obx(
        () => Container(
          alignment: Alignment.center,
          child: Text(title,
              style: TextStyle(
                  color: _type.value == key
                      ? Theme.of(context).primaryColor
                      : Colors.white70)),
          color: _type.value == key ? Colors.white : null,
        ),
      ),
    );
  }
}
