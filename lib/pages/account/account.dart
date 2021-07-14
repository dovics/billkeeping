import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:billkeeping/data/services/all_account_manage/all_account_manage_abstract.dart';
import 'package:get/get.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:billkeeping/common/iconfont.dart';
import 'package:billkeeping/data/models/account_info_model.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<AccountPage> {
  SlidableController _slidableController;
  DatePickerController _datePickerController;
  @override
  void initState() {
    super.initState();
    _slidableController = SlidableController();
    _datePickerController = DatePickerController();

    Future.delayed(Duration(microseconds: 500), () {
      _datePickerController.animateToSelection(
          duration: Duration(milliseconds: 200));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AbstractAllAccountManage>(
      init: Get.find<AbstractAllAccountManage>(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            "账单",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            DatePicker(
              DateTime.now().subtract(Duration(days: 100)),
              controller: _datePickerController,
              initialSelectedDate: DateTime.now(),
              selectionColor: Theme.of(context).primaryColor,
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                controller.getAccountsByDate(date);
              },
            ),
            Container(
              height: MediaQuery.of(context).size.height - 150,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: controller.accountByDate.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  AccountInfoModel mo = controller.accountByDate[index];
                  return Slidable(
                    actionExtentRatio: .15,
                    actionPane: SlidableScrollActionPane(),
                    controller: _slidableController,
                    child: ListTile(
                      onTap: () => _slidableController.activeState?.close(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      leading: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xffeeeeee),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(IconFont.icon[mo.icon]),
                      ),
                      title: Text(mo.name),
                      //subtitle: index % 2 == 0 ? Text('备注信息') : null,
                      trailing: Text('${mo.type == 1 ? '-' : ''}${mo.money}'),
                    ),
                    secondaryActions: <Widget>[
                      Builder(
                        builder: (context) => SlideAction(
                          child:
                              Text('删除', style: TextStyle(color: Colors.white)),
                          color: Colors.red,
                          closeOnTap: false,
                          onTap: () {
                            _slidableController.activeState?.close();
                          },
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: 0,
                  thickness: .5,
                  color: Color(0xFFeeeeee),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
