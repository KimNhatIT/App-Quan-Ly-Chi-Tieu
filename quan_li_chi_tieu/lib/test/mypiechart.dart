import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:quan_li_chi_tieu/data/spending_data.dart';
import 'package:quan_li_chi_tieu/models/spending.dart';

class MyPieChart extends StatelessWidget {
  const MyPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    List<Spending>? listSpendingofUser = listSpending['hoang'];
    Map<String, double> dataMap = {}; // Đúng kiểu dữ liệu
    for (Spending spending in listSpendingofUser!) {
      dataMap[spending.name] =
          spending.amount.toDouble(); // Chuyển int -> double
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
