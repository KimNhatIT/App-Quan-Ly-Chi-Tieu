import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:quan_li_chi_tieu/data/spending_data.dart';
import 'package:quan_li_chi_tieu/models/account.dart';
import 'package:quan_li_chi_tieu/models/spending.dart';

class MyPieChart extends StatelessWidget {
  final Account? accountNow;
  MyPieChart({super.key, this.accountNow});

  @override
  Widget build(BuildContext context) {
    List<Spending>? listSpendingofUser = listSpending[accountNow!.username];
    Map<String, double> dataMap = {}; // Khởi tạo map rỗng

    if (listSpendingofUser != null && listSpendingofUser.isNotEmpty) {
      for (Spending spending in listSpendingofUser) {
        dataMap[spending.name] =
            spending.amount.toDouble(); // Chuyển int -> double
      }
    } else {
      // Nếu danh sách rỗng, có thể thêm dữ liệu mặc định nếu cần
      dataMap["Không có dữ liệu"] = 0.0;
    }

    return Container(
      color: Colors.grey[350],
      child: Center(
        child: PieChart(
          dataMap: dataMap,
          animationDuration: Duration(milliseconds: 800),
          chartRadius: MediaQuery.of(context).size.width / 3,
          chartType: ChartType.ring, // hoặc ring nếu muốn vòng khuyết
          chartValuesOptions: ChartValuesOptions(
            showChartValuesInPercentage: true,
            showChartValues: true,
            showChartValuesOutside: true,
          ),
        ),
      ),
    );
  }
}
