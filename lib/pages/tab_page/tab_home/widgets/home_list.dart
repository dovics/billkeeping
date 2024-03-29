import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:billkeeping/common/iconfont.dart';
import 'package:billkeeping/data/models/account_info_model.dart';
import 'package:billkeeping/data/models/sum_account_model.dart';
import 'package:billkeeping/data/services/account_manage/account_manage_abstract.dart';
import 'package:billkeeping/pages/tab_page/tab_home/widgets/week.dart';

class HomeList extends StatelessWidget {
  const HomeList({Key key, @required SlidableController slidableController})
      : _slidableController = slidableController,
        super(key: key);

  final SlidableController _slidableController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AbstractAccountManage>(
      init: Get.find<AbstractAccountManage>(),
      builder: (controller) {
        // return AnimatedSwitcher(
        //   duration: Duration(milliseconds: 500),
        //   transitionBuilder: (Widget child, Animation<double> animation) =>
        //       SlideTransitionX(
        //     child: child,
        //     direction: controller.direction,
        //     position: animation,
        //   ),
        // child:
        return controller.sumAccountModelList.length > 0
            ? ListView(
                // key: ValueKey(controller.curDate),
                padding: EdgeInsets.only(top: 0, bottom: 30),
                children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: BarChartSample1(),
                    ),
                    ...List.generate(
                      controller.sumAccountModelList.length,
                      (index) =>
                          buildColumn(controller.sumAccountModelList[index]),
                    ),
                  ])
            : Container(
                height: 200,
                margin: EdgeInsets.only(bottom: 100),
                child: Icon(
                  Icons.delete_forever,
                  size: 200,
                  color: Colors.black12,
                ),
              );
      },
    );
  }

  Column buildColumn(SumAccountModel model) {
    return Column(
      children: [
        Container(
          height: 50,
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Row(
            children: [
              Text(model.date, style: TextStyle(color: Colors.black54)),
              SizedBox(width: 10),
              Text(model.weekdayStr, style: TextStyle(color: Colors.black54)),
              Expanded(child: Container()),
              Text('支出：${model.payMoney}',
                  style: TextStyle(color: Colors.black54)),
              SizedBox(width: 10),
              Text('收入：${model.incomeMoney}',
                  style: TextStyle(color: Colors.black54)),
            ],
          ),
        ),
        Divider(height: 0, thickness: .5, color: Color(0xffe0e0e0)),
        ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: model.childen.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            AccountInfoModel mo = model.childen[index];
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
                    child: Text('删除', style: TextStyle(color: Colors.white)),
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
          separatorBuilder: (context, index) =>
              Divider(height: 0, thickness: .5, color: Color(0xFFeeeeee)),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    Key key,
    @required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    this.child,
  })  : assert(position != null),
        super(key: key, listenable: position) {
    // 偏移在内部处理
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }

  Animation<double> get position => listenable;

  final bool transformHitTests;

  final Widget child;

  //退场（出）方向
  final AxisDirection direction;

  Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    print("offset.dx $offset");
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
