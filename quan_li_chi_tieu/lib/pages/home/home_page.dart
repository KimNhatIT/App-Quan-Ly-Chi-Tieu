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
  final Account? accountNow;
  const HomePage({super.key, this.accountNow});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _getListSpending() async {
    Map<String, List<Spending>> data = await ShareService.getAllUserSpending();
    setState(() {
      listSpending = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getListSpending();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trang chủ')),
      drawer: DrawerMenu(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 5 / 10,
              child: MyPieChart(accountNow: widget.accountNow),
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
                        if (listSpending[widget.accountNow!.username] == null ||
                            listSpending[widget.accountNow!.username]!.isEmpty)
                          const Center(
                            child: Column(
                              children: [
                                SizedBox(height: 50),
                                Text('Chưa có giao dịch nào'),
                              ],
                            ),
                          ),
                        if (listSpending[widget.accountNow!.username] != null &&
                            listSpending[widget.accountNow!.username]!
                                .isNotEmpty)
                          ...(() {
                            // Tạo bản sao và sắp xếp theo ngày giảm dần (mới nhất trước)
                            final sortedList = List<Spending>.from(
                              listSpending[widget.accountNow!.username]!,
                            )..sort((a, b) => b.date.compareTo(a.date));
                            return sortedList.map((spending) {
                              return TransactionItem(
                                spending,
                                onDelete: () {
                                  AppDialog.dialog(
                                    context,
                                    content: 'Xác nhận xóa?',
                                    action: () {
                                      listSpending[widget.accountNow!.username]
                                          ?.removeWhere(
                                            (item) => item.id == spending.id,
                                          );

                                      setState(() {
                                        ShareService.saveUserSpending(
                                          listSpending,
                                        );
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
                                        ShareService.saveUserSpending(
                                          listSpending,
                                        );
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
                                (context) => AddTransactionPage(
                                  accountNow: widget.accountNow,
                                ),
                          ),
                        );
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
