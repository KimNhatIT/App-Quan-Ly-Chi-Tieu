import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/models/spending.dart';

class TransactionItem extends StatelessWidget {
  final Spending spending;

  const TransactionItem({super.key, required this.spending});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(spending.icon, color: spending.color),
          title: Text(spending.name),
          subtitle: Column(
            children: [
              Row(
                children: [
                  const SizedBox(height: 5),
                  const Text('Số tiền: '),
                  if (spending.type == 'Tiền chi')
                    Text(
                      '-${spending.amount} VNĐ',
                      style: const TextStyle(color: Colors.red),
                    )
                  else
                    Text(
                      '+${spending.amount} VNĐ',
                      style: const TextStyle(color: Colors.green),
                    ),
                ],
              ),
              Row(
                children: [
                  Text('Ngày: ', style: TextStyle(color: Colors.grey)),
                  Text(
                    '${spending.date.day}/${spending.date.month}/${spending.date.year}',
                  ),
                ],
              ),
            ],
          ),

          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.grey),
            onPressed: () {},
          ),
          onTap: () {},
        ),
        const Divider(),
      ],
    );
  }
}
