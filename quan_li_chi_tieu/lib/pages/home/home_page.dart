import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/components/drawer_menu.dart';
import 'package:quan_li_chi_tieu/components/transaction_item.dart';
import 'package:quan_li_chi_tieu/test/mypiechart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
            Text('Lịch sử giao dịch', style: TextStyle(fontSize: 20)),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    for (int i = 0; i < 10; i++) const TransactionItem(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
