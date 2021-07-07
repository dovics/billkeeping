import 'package:flutter/material.dart';
import 'package:billkeeping/data/services/all_account_manage/all_account_manage_abstract.dart';
import 'package:get/get.dart';
import 'package:billkeeping/data/models/account_info_model.dart';
import 'package:billkeeping/common/iconfont.dart';
import 'package:billkeeping/pages/timeline/widget/tag.dart';
import 'package:billkeeping/pages/timeline/widget/date.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelinePage extends GetView<AbstractAllAccountManage> {
  List<TimelineTile> generateDataRow(List<AccountInfoModel> allAccounts) {
    allAccounts.sort((account1, account2) {
      var data1 = DateTime.parse(account1.date);
      var data2 = DateTime.parse(account2.date);
      if (data1.isAfter(data2)) {
        return -1;
      } else {
        return 1;
      }
    });

    List<TimelineTile> tiles = List.empty(growable: true);
    DateTime lastTime = DateTime.now();
    tiles.add(TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.3,
      endChild: Container(
        //height: 20,
        margin: EdgeInsets.only(left: 10),
        child: Text("Today"),
      ),
    ));
    for (var account in allAccounts) {
      var datetime = DateTime.parse(account.date);
      if (lastTime.day != datetime.day) {
        tiles.add(TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.3,
          endChild: Container(
            //height: 20,
            child: Date(datetime),
          ),
        ));
      }
      lastTime = datetime;

      tiles.add(
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.3,
          indicatorStyle: IndicatorStyle(
            width: 40,
            color: account.type == 1 ? Colors.yellow[900] : Colors.green[800],
            padding: EdgeInsets.all(8),
            iconStyle: IconStyle(
              fontSize: 20,
              color: Colors.white,
              iconData: IconFont.icon[account.icon],
            ),
          ),
          startChild: Container(
            alignment: AlignmentDirectional.centerEnd,
            child: Time(datetime),
          ),
          endChild: Container(
            child: Stack(
              children: [
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Tag(account.name,
                      type:
                          account.type == 1 ? TagType.Warning : TagType.Success),
                ),
                Container(
                  alignment: AlignmentDirectional.centerEnd,
                  height: 80,
                  margin: EdgeInsets.only(right: 20),
                  child: Text(
                    account.type == 1
                        ? "-" + account.money.toString()
                        : "+" + account.money.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        color: account.type == 1
                            ? Colors.red[400]
                            : Colors.green[400]),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AbstractAllAccountManage>(
      init: Get.find<AbstractAllAccountManage>(),
      builder: (controller) => Scaffold(
        appBar: AppBar(),
        body: Container(
          child: ListView(
            children: [...generateDataRow(controller.allAccounts)],
          ),
        ),
      ),
    );
  }
}
