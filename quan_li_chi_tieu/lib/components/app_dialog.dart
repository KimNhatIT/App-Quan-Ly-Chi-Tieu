import 'package:flutter/material.dart';

class AppDialog {
  AppDialog._();

  static Future<void> dialog(
    BuildContext context, {
    Widget? title,
    required String content,
    Function()? action,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: title,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  content,
                  style: const TextStyle(color: Colors.brown, fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Icon(Icons.close, color: Colors.red, size: 17),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Icon(Icons.check, color: Colors.green, size: 17),
              onPressed: () {
                action?.call();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> editlog(
    BuildContext context, {
    Widget? title,
    required String content,
    required Function(int amount, DateTime date) onConfirm,
    int initialAmount = 0,
    DateTime? initialDate,
  }) {
    final TextEditingController amountController = TextEditingController(
      text: initialAmount.toString(),
    );
    DateTime selectedDate = initialDate ?? DateTime.now();

    Future<void> _selectDate(
      BuildContext context,
      void Function(void Function()) setState,
    ) async {
      final picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: title,
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      content,
                      style: const TextStyle(
                        color: Colors.brown,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text('Số tiền: '),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: amountController,
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
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectDate(context, setState),
                          child: const Icon(Icons.calendar_month_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Icon(Icons.close, color: Colors.red, size: 17),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Icon(Icons.check, color: Colors.green, size: 17),
                  onPressed: () {
                    final int? amount = int.tryParse(amountController.text);
                    if (amount == null) {
                      // Bạn có thể thêm báo lỗi nếu cần
                      return;
                    }
                    onConfirm(amount, selectedDate);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
