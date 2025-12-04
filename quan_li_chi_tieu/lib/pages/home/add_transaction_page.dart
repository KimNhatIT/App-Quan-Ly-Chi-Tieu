import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/components/drawer_menu.dart';
import 'package:quan_li_chi_tieu/data/spending_data.dart';
import 'package:quan_li_chi_tieu/models/account.dart';
import 'package:quan_li_chi_tieu/models/spending.dart';
import 'package:quan_li_chi_tieu/pages/home/home_page.dart';
import 'package:quan_li_chi_tieu/services/share_service.dart';

class AddTransactionPage extends StatefulWidget {
  final Account? accountNow;
  const AddTransactionPage({super.key, this.accountNow});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final TextEditingController _amountController = TextEditingController();

  String? selecValue = 'Tiền chi';
  List<String> type_transaction = ['Tiền chi', 'Tiền thu'];
  DateTime selectedDate = DateTime.now();

  String selectedCategory = 'Ăn uống'; // Mặc định

  void _getListSpending() async {
    Map<String, List<Spending>>? data =
        await ShareService.getAllMapSpendingFromJson();
    setState(() {
      listSpending = data;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget buildCategory(String name, IconData icon, Color? color) {
    final isSelected = selectedCategory == name;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategory = name;
          });
        },
        child: Container(
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? color?.withOpacity(0.3) : Colors.transparent,
            border: Border.all(color: color ?? Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color),
              SizedBox(height: 4),
              Text(name, style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }

  void _addSpanding() {
    final String? typeSpending = selecValue;
    final String money = _amountController.text.trim();
    final DateTime date = selectedDate;
    final String typeCategory = selectedCategory;

    IconData icon;
    Color color;

    switch (selectedCategory) {
      case 'Ăn uống':
        icon = Icons.fastfood;
        color = Colors.green;
        break;
      case 'Tiền điện':
        icon = Icons.flash_on;
        color = Colors.yellow[600]!;
        break;
      case 'Đi lại':
        icon = Icons.directions_car_filled;
        color = Colors.indigo;
        break;
      case 'Tiền điện thoại':
        icon = Icons.phone_android;
        color = Colors.grey;
        break;
      case 'Tiền học':
        icon = Icons.menu_book;
        color = Colors.blue;
        break;
      case 'Tiền nước':
        icon = Icons.water_drop;
        color = Colors.blue[300]!;
        break;
      case 'Mua sắm':
        icon = Icons.shopping_cart;
        color = Colors.orange;
        break;
      case 'Tiền lương':
        icon = Icons.attach_money;
        color = Colors.green;
        break;
      default:
        icon = Icons.auto_awesome_motion_rounded;
        color = Colors.grey;
    }

    if (money.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Vui lòng nhập Số tiền')));
      return;
    } else if (int.parse(money) < 1000) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Số tiền tối thiểu có thể nhập là 1000')),
      );
      return;
    } else {
      final username = widget.accountNow!.username;
      final List<Spending>? userSpending = listSpending?[username];

      if (!listSpending!.containsKey(username) || userSpending!.isEmpty) {
        listSpending?.addAll({
          username: [
            Spending(
              id: 1,
              type: typeSpending!,
              amount: int.parse(money),
              color: color,
              icon: icon,
              name: typeCategory,
              date: date,
            ),
          ],
        });
        ShareService.saveMapSpendingToJson(listSpending!);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Đã thêm giao dịch')));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(accountNow: widget.accountNow!),
          ),
          (Route<dynamic> route) => false,
        );
      } else {
        int maxID = 0;
        for (Spending spending in userSpending) {
          if (spending.id > maxID) {
            maxID = spending.id;
          }
        }
        int newID = maxID + 1;
        listSpending?[username]!.add(
          Spending(
            id: newID,
            type: typeSpending!,
            amount: int.parse(money),
            color: color,
            icon: icon,
            name: typeCategory,
            date: date,
          ),
        );
        ShareService.saveMapSpendingToJson(listSpending!);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(accountNow: widget.accountNow!),
          ),
          (Route<dynamic> route) => false,
        );
      }
    }
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
      appBar: AppBar(title: const Text('Thêm Giao Dịch')),
      drawer: DrawerMenu(widget.accountNow!),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Loại giao dịch:'),
                const Spacer(),
                DropdownButton<String>(
                  value: selecValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selecValue = newValue;
                    });
                  },
                  items:
                      type_transaction.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Số tiền: '),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                const Text('VNĐ'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Ngày: '),
                const SizedBox(width: 10),
                Expanded(
                  child: Center(
                    child: Text(
                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Icon(Icons.calendar_month_outlined),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(children: [Text('Danh mục:')]),
            const SizedBox(height: 10),
            Column(
              children: [
                Row(
                  children: [
                    buildCategory('Ăn uống', Icons.fastfood, Colors.green),
                    buildCategory(
                      'Tiền điện',
                      Icons.flash_on,
                      Colors.yellow[600],
                    ),
                    buildCategory(
                      'Đi lại',
                      Icons.directions_car_filled,
                      Colors.indigo,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    buildCategory(
                      'Tiền điện thoại',
                      Icons.phone_android,
                      Colors.grey,
                    ),
                    buildCategory('Tiền học', Icons.menu_book, Colors.blue),
                    buildCategory(
                      'Tiền nước',
                      Icons.water_drop,
                      Colors.blue[300],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    buildCategory(
                      'Mua sắm',
                      Icons.shopping_cart,
                      Colors.orange,
                    ),
                    buildCategory(
                      'Tiền lương',
                      Icons.attach_money,
                      Colors.green,
                    ),
                    buildCategory(
                      'Khác',
                      Icons.auto_awesome_motion_rounded,
                      Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 200),
            ElevatedButton(onPressed: _addSpanding, child: const Text('Thêm')),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
