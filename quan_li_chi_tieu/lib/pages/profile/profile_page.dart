import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/components/app_dialog.dart';
import 'package:quan_li_chi_tieu/components/drawer_menu.dart';
import 'package:quan_li_chi_tieu/data/accounts_data.dart';
import 'package:quan_li_chi_tieu/data/spending_data.dart';
import 'package:quan_li_chi_tieu/models/account.dart';
import 'package:quan_li_chi_tieu/pages/home/splash_page.dart';
import 'package:quan_li_chi_tieu/services/share_service.dart';

class ProfilePage extends StatelessWidget {
  final Account accountNow;

  const ProfilePage({super.key, required this.accountNow});

  Future<void> _deleteAccount() async {
    try {
      listAccounts = await ShareService.getListAccountsFromJson();
      listSpending = await ShareService.getAllMapSpendingFromJson();

      listAccounts.removeWhere((acc) => acc.username == accountNow.username);
      listSpending?.remove(accountNow.username);

      ShareService.saveListAccountToJson(listAccounts);
      ShareService.saveMapSpendingToJson(listSpending!);
    } catch (e) {
      print('Lỗi xóa tài khoản: $e');
    }
  }

  Future<bool> _checkAccount() async {
    try {
      listAccounts = await ShareService.getListAccountsFromJson();
      listSpending = await ShareService.getAllMapSpendingFromJson();

      if (listSpending!.containsKey(accountNow.username)) {
        print('Lỗi chưa xóa danh sách giao dịch');
        return true;
      } else {
        for (Account acc in listAccounts) {
          if (acc.username == accountNow.username) {
            print('Lỗi chưa xóa tài khoản khỏi danh sách tài khoản');
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      print('Lỗi khi lấy tài khoản từ list: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thông tin cá nhân')),
      drawer: DrawerMenu(accountNow),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.account_circle, size: 100, color: Colors.blue),
              Text(
                accountNow.username,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Icon(Icons.person, size: 30, color: Colors.blue),
                  Text(accountNow.fullname, style: TextStyle(fontSize: 20)),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Icon(Icons.email, size: 30, color: Colors.blue),
                  Text(accountNow.email, style: TextStyle(fontSize: 20)),
                ],
              ),
              const Spacer(),
              Center(
                child: ListTile(
                  title: Text(
                    'Xóa tài khoản',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    AppDialog.dialog(
                      context,
                      content: 'Xác nhận xóa tài khoản?',
                      action: () async {
                        await _deleteAccount();

                        bool checkAccount = await _checkAccount();

                        if (checkAccount) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Đã xảy ra lỗi khi xóa tài khoản'),
                            ),
                          );
                        } else {
                          ShareService.clearSavedAccount();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Đã xóa tài khoản')),
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SplashPage(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
