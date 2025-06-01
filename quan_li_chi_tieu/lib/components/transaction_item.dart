import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.fastfood_rounded, color: Colors.green),
          title: Text('Giao dịch ${DateTime.now().toLocal()}'),
          subtitle: Text('Số tiền: 100.000 VNĐ'),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
          onTap: () {},
        ),
        Divider(),
      ],
    );
  }
}
