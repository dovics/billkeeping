import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:billkeeping/common/year_month_picker.dart';
import 'package:billkeeping/data/services/account_manage/account_manage_abstract.dart';
import 'package:billkeeping/data/services/account_manage/account_manage_service.dart';

class HomeSum extends StatelessWidget {
  HomeSum({Key key}) : super(key: key);

  final _dateTime = DateTime.now().obs;

  @override
  Widget build(BuildContext context) {
    AccountManageService ams = Get.find<AbstractAccountManage>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            DatePicker.showPicker(
              context,
              showTitleActions: true,
              locale: LocaleType.zh,
              pickerModel: YearMonthPicker(
                  locale: LocaleType.zh, currentTime: _dateTime.value),
              onConfirm: (date) {
                _dateTime.value = date;
                ams.getSumAccount(date.toString().substring(0, 7));
              },
            );
          },
          child: Container(
            width: 70,
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${_dateTime.value.year}年',
                      style: TextStyle(color: Colors.white60)),
                  Text.rich(TextSpan(
                    children: [
                      TextSpan(
                          text:
                              '${_dateTime.value.month < 10 ? '0' : ''}${_dateTime.value.month}',
                          style: TextStyle(fontSize: 32, color: Colors.white)),
                      TextSpan(
                          text: '月', style: TextStyle(color: Colors.white)),
                      TextSpan(
                          text: ' ▼', style: TextStyle(color: Colors.white)),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: 1,
          height: 30,
          color: Colors.black12,
          margin: EdgeInsets.only(right: 24, left: 16),
        ),
        Expanded(
          child: GetBuilder<AbstractAccountManage>(
            init: Get.find<AbstractAccountManage>(),
            builder: (_) => Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('收入', style: TextStyle(color: Colors.white60)),
                      Text(
                        '${_.monthSum['incomeMoney']}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('支出', style: TextStyle(color: Colors.white60)),
                      Text(
                        '${_.monthSum['payMoney']}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
