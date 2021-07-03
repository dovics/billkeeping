import 'package:billkeeping/data/services/account_mange/account_mange_abstract.dart';
import 'package:billkeeping/data/services/account_mange/account_mange_service.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory PieChart.withData(String type) {
    return PieChart(
      _createData(type),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: charts.PieChart(
        seriesList,
        animate: animate,
        defaultRenderer: charts.ArcRendererConfig(arcRendererDecorators: [
          charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.outside)
        ]),
      ),
    );
  }

  static List<charts.Series<LinearSales, int>> _createData(String type) {
    AccountMangeService chartManageService = Get.find<AbstractAccountMange>();
    final maps = chartManageService.getPieData(type);

    final data = [
      LinearSales("收入", maps["incomeMoney"]),
      LinearSales("支出", maps["payMoney"]),
    ];
    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) {
          switch (sales.type) {
            case "收入":
              return 0;
            case "支出":
              return 1;
            default:
              return 2;
          }
        },
        measureFn: (LinearSales sales, _) => sales.amount,
        // colorFn: (LinearSales sales, _) {
        //   switch (sales.type) {
        //     case "收入":
        //       return charts.Color(r: 193, g: 255, b: 193);
        //     case "支出":
        //       return charts.Color(r: 255, g: 99, b: 71);
        //     default:
        //       return charts.Color.black;
        //   }
        // },
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.type}: ${row.amount}',
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final String type;
  final double amount;

  LinearSales(this.type, this.amount);
}
