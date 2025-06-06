import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/models/account.dart';
import 'package:quan_li_chi_tieu/models/spending.dart';

Account? account;

Map<String, List<Spending>> listSpending = {
  'hoang': [
    Spending(
      id: 1,
      type: 'Tiền chi',
      amount: 500000,
      date: DateTime.now(),
      name: 'Ăn uống',
      icon: Icons.fastfood,
      color: Colors.green,
    ),
    Spending(
      id: 2,
      type: 'Tiền chi',
      amount: 400000,
      date: DateTime.now(),
      name: 'Tiền học',
      icon: Icons.menu_book,
      color: Colors.blue,
    ),
    Spending(
      id: 3,
      type: 'Tiền thu',
      amount: 4000000,
      date: DateTime.now(),
      name: 'Tiền lương',
      icon: Icons.attach_money,
      color: Colors.green,
    ),
  ],
};
