import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:quan_li_chi_tieu/data/spending_data.dart';
import 'package:quan_li_chi_tieu/models/account.dart';
import 'package:quan_li_chi_tieu/models/spending.dart';
import 'package:quan_li_chi_tieu/services/share_service.dart';

class MyPieChart extends StatefulWidget {
  final Account accountNow;
  const MyPieChart(this.accountNow, {super.key});

  @override
  State<MyPieChart> createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {
  Account? _account;

  Future<void> _getListSpending() async {
    Map<String, List<Spending>>? data =
        await ShareService.getAllMapSpendingFromJson();
    setState(() {
      listSpending = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getListSpending();
    _account = widget.accountNow;
  }

  @override
  Widget build(BuildContext context) {
    List<Spending>? listSpendingofUser = listSpending?[_account!.username];
    Map<String, double> dataMap = {}; // Khởi tạo map rỗng

    if (listSpendingofUser != null && listSpendingofUser.isNotEmpty) {
      for (Spending spending in listSpendingofUser) {
        // Nếu đã có key, cộng dồn
        if (dataMap.containsKey(spending.name)) {
          double tmp = spending.amount.toDouble(); // Đảm bảo kiểu double
          double? tmpValue = dataMap[spending.name];
          double valueNew = tmp + tmpValue!;
          dataMap[spending.name] = valueNew;
        } else {
          // Nếu chưa có key, thêm mới
          dataMap[spending.name] = spending.amount.toDouble();
        }
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
          chartRadius: MediaQuery.of(context).size.width / 3.5,
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
