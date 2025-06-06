import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/components/drawer_menu.dart';
import 'package:quan_li_chi_tieu/components/transaction_item.dart';
import 'package:quan_li_chi_tieu/data/spending_data.dart';
import 'package:quan_li_chi_tieu/models/account.dart';
import 'package:quan_li_chi_tieu/models/spending.dart';
import 'package:quan_li_chi_tieu/pages/home/add_transaction_page.dart';
import 'package:quan_li_chi_tieu/test/mypiechart.dart';

class HomePage extends StatefulWidget {
  final Account? accountNow;
  const HomePage({super.key, this.accountNow});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              height: MediaQuery.of(context).size.width * 2 / 3,
              child: MyPieChart(),
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
                              return TransactionItem(spending: spending);
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
