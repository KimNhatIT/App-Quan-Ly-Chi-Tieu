import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class MyPieChart extends StatelessWidget {
  const MyPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {"Học tập": 10, "Mua Sắm": 40, "Ăn uống": 40};
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
