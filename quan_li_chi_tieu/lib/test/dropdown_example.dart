import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/components/drawer_menu.dart';

class DropdownExample extends StatefulWidget {
  @override
  _DropdownExampleState createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  String? selectedValue = 'Apple'; // giá trị mặc định

  List<String> options = ['Apple', 'Banana', 'Orange', 'Grapes'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DropdownButton Example')),
      drawer: DrawerMenu(),
      body: Center(
        child: DropdownButton<String>(
          value: selectedValue,
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue;
            });
          },
          items:
              options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ),
      ),
    );
  }
}
