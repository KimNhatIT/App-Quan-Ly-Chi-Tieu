import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/components/drawer_menu.dart';
import 'package:quan_li_chi_tieu/data/accounts_data.dart';
import 'package:quan_li_chi_tieu/models/account.dart';
import 'package:quan_li_chi_tieu/services/share_service.dart';

class ListAccount extends StatefulWidget {
  const ListAccount({super.key});

  @override
  State<ListAccount> createState() => _ListAccountState();
}

class _ListAccountState extends State<ListAccount> {
  void loadAccounts() async {
    List<Account> accounts = await ShareService.getAccountList();
    setState(() {
      listAccounts = accounts;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAccounts();
  }

  void _printListAccount() {
    if (listAccounts.isEmpty) {
      print('Không có danh sách tài khoản nào');
    } else {
      for (Account account in listAccounts) {
        print(account.username);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Danh sách tài khoản')),
      drawer: const DrawerMenu(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _printListAccount,
            child: const Text('In danh sách tài khoản'),
          ),
        ],
      ),
    );
  }
}
