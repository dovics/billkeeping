import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:billkeeping/data/services/account_manage/account_manage_abstract.dart';
import 'package:billkeeping/data/services/account_manage/account_manage_service.dart';
import 'package:billkeeping/pages/tab_page/tab_home/widgets/home_list.dart';
import 'package:billkeeping/pages/tab_page/tab_home/widgets/home_sum.dart';

import 'widgets/home_nav.dart';

class TabHomePage extends StatefulWidget {
  @override
  _TabHomePageState createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage>
    with AutomaticKeepAliveClientMixin {
  final double _bgHeight = 170;
  final double _titleHeight = 50;
  final double _sumHeight = 80;
  final double _navHeight = 80;
  SlidableController _slidableController;
  AccountManageService accountManageService;

  @override
  void initState() {
    accountManageService = AccountManageService();
    // 注入 AccountManageService
    Get.put<AbstractAccountManage>(accountManageService);

    super.initState();
    _slidableController = SlidableController(
      onSlideIsOpenChanged: _handleSlideIsOpenChanged,
    );
  }

  void _handleSlideIsOpenChanged(bool isOpen) {
    print(isOpen);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final double topPadding = MediaQuery.of(context).padding.top;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: SizedBox(
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              top: _sumHeight + _navHeight + _titleHeight + topPadding,
              left: 0,
              right: 0,
              bottom: 0,
              child: HomeList(
                slidableController: _slidableController,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              height: _bgHeight + topPadding,
              child: Container(
                  height: _bgHeight + topPadding,
                  color: Theme.of(context).primaryColor),
            ),
            Positioned(
              top: topPadding,
              left: 0,
              right: 0,
              height: _titleHeight,
              child:
                  Center(child: Text('账单明细', style: TextStyle(fontSize: 20, color: Colors.white))),
            ),
            Positioned(
              top: _titleHeight + topPadding,
              left: 20,
              right: 10,
              height: _sumHeight,
              child: HomeSum(),
            ),
            Positioned(
              top: _sumHeight + _titleHeight + topPadding,
              left: 10,
              right: 10,
              height: _navHeight,
              child: HomeNav(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
