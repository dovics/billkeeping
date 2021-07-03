import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:billkeeping/data/services/account_mange/account_mange_abstract.dart';
import 'package:billkeeping/data/services/account_mange/account_mange_service.dart';
import 'package:get/get.dart';

class BarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  BarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory BarChart.withData(String type) {
    return BarChart(
      _createData(type),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createData(String type) {
    AccountMangeService chartManageService = Get.find<AbstractAccountMange>();
    final maps = chartManageService.getBarData(type);
    List<OrdinalSales> data = List.empty(growable: true);

    for(var value in maps) {
      data.add(OrdinalSales(value["name"], value["payMoney"]));
    }

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        // colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.type,
        measureFn: (OrdinalSales sales, _) => sales.mount,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String type;
  final int mount;

  OrdinalSales(this.type, this.mount);
}
