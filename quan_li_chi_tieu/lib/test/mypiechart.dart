import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class MyPieChart extends StatelessWidget {
  const MyPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {"A": 10, "B": 40, "C": 40};

    return Scaffold(
      appBar: AppBar(title: Text('Biểu đồ phần trăm')),
      body: Center(
        child: PieChart(
          dataMap: dataMap,
          animationDuration: Duration(milliseconds: 800),
          chartRadius: MediaQuery.of(context).size.width / 2.2,
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
