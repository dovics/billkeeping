import 'package:billkeeping/data/services/all_account_manage/all_account_manage_abstract.dart';
import 'package:billkeeping/data/provider/all_account_db_provider.dart';

class AllAbstractAccountManage extends AbstractAllAccountManage {
  Future<void> getAllAccounts() async {
    AllAccountsDbProvider aadp = AllAccountsDbProvider();
    allAccounts = await aadp.getAllAccountsInfo();
    update();
  }

Future<void> getAccountsByDate(DateTime date) async {
    AllAccountsDbProvider aadp = AllAccountsDbProvider();
    accountByDate = await aadp.getAccountsInfoByDate(date);
    update();
  }

  @override
  void onReady() {
    super.onReady();
    getAllAccounts();
    getAccountsByDate(DateTime.now());
    print('ready');
  }
}
