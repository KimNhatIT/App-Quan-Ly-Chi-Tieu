import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/components/app_dialog.dart';
import 'package:quan_li_chi_tieu/components/drawer_menu.dart';
import 'package:quan_li_chi_tieu/components/transaction_item.dart';
import 'package:quan_li_chi_tieu/data/spending_data.dart';
import 'package:quan_li_chi_tieu/models/account.dart';
import 'package:quan_li_chi_tieu/models/spending.dart';
import 'package:quan_li_chi_tieu/pages/home/add_transaction_page.dart';
import 'package:quan_li_chi_tieu/components/mypiechart.dart';
import 'package:quan_li_chi_tieu/services/share_service.dart';

class HomePage extends StatefulWidget {
  final Account accountNow;
  const HomePage({super.key, required this.accountNow});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _income = 0;
  int _expense = 0;
  int _balance = 0;

  late Account _account;

  Future<void> _getValueForStatistical() async {
    int tmpIncome = 0;
    int tmpExpence = 0;
    int tmpBalance = 0;

    listSpending = await ShareService.getAllMapSpendingFromJson();

    if (!listSpending!.containsKey(_account.username) ||
        listSpending![_account.username]!.isEmpty) {
      setState(() {
        _income = tmpIncome;
        _expense = tmpExpence;
      });
    } else {
      for (Spending spending in listSpending![_account.username]!) {
        if (spending.type == 'Tiền thu') {
          tmpIncome += spending.amount;
        } else {
          tmpExpence += spending.amount;
        }
      }
      setState(() {
        _income = tmpIncome;
        _expense = tmpExpence;
        tmpBalance = tmpIncome - tmpExpence;
        _balance = tmpBalance;
        print('$tmpExpence : $tmpIncome : $tmpBalance');
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getValueForStatistical();
    _account = widget.accountNow;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trang chủ')),
      drawer: DrawerMenu(_account),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,

              child: MyPieChart(_account),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 10),
                Text('Lịch sử giao dịch', style: TextStyle(fontSize: 20)),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Divider(),
                        if (listSpending![_account.username] == null ||
                            listSpending![_account.username]!.isEmpty)
                          const Center(
                            child: Column(
                              children: [
                                SizedBox(height: 50),
                                Text('Chưa có giao dịch nào'),
                              ],
                            ),
                          ),
                        if (listSpending![_account.username] != null &&
                            listSpending![_account.username]!.isNotEmpty)
                          ...(() {
                            // Tạo bản sao và sắp xếp theo ngày giảm dần (mới nhất trước)
                            final sortedList = List<Spending>.from(
                              listSpending![_account.username]!,
                            )..sort((a, b) => b.date.compareTo(a.date));
                            return sortedList.map((spending) {
                              return TransactionItem(
                                spending,
                                onDelete: () {
                                  AppDialog.dialog(
                                    context,
                                    content: 'Xác nhận xóa giao dịch?',
                                    action: () {
                                      listSpending![_account.username]
                                          ?.removeWhere(
                                            (item) => item.id == spending.id,
                                          );

                                      setState(() {
                                        ShareService.saveMapSpendingToJson(
                                          listSpending!,
                                        );
                                        _getValueForStatistical();
                                      });
                                    },
                                  );
                                },
                                onEdit: () {
                                  AppDialog.editlog(
                                    context,
                                    content: 'Chỉnh sửa thông tin',
                                    initialAmount: spending.amount,
                                    initialDate: spending.date,
                                    onConfirm: (
                                      int newAmount,
                                      DateTime newDate,
                                    ) {
                                      setState(() {
                                        spending.amount = newAmount;
                                        spending.date = newDate;
                                        ShareService.saveMapSpendingToJson(
                                          listSpending!,
                                        );
                                        _getValueForStatistical();
                                      });
                                    },
                                  );
                                },
                              );
                            }).toList();
                          })(),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    right: 40,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    AddTransactionPage(accountNow: _account),
                          ),
                        );
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  const Spacer(),
                  Icon(Icons.list, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text('Thống kê', style: TextStyle(color: Colors.blue)),
                  const Spacer(),
                ],
              ),
              onTap: () {
                AppDialog.showStatistical(
                  context,
                  income: _income,
                  expense: _expense,
                  balance: _balance,
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
