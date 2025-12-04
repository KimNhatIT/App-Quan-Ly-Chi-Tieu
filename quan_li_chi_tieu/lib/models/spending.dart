import 'package:flutter/widgets.dart';

class Spending {
  int _id;
  String _type;
  String _name;
  int _amount;
  IconData _icon;
  Color? _color;
  DateTime _date;

  Spending({
    required int id,
    required String type,
    required String name,
    required int amount,
    required IconData icon,
    required Color? color,
    required DateTime date,
  }) : _id = id,
       _type = type,
       _name = name,
       _amount = amount,
       _icon = icon,
       _color = color,
       _date = date;

  int get id => _id;
  set id(int value) => _id = id;

  String get type => _type;
  set type(String value) => _type = value;

  String get name => _name;
  set name(String value) => _name = value;

  int get amount => _amount;
  set amount(int value) => _amount = value;

  IconData get icon => _icon;
  set icon(IconData value) => _icon = value;

  Color? get color => _color;
  set color(Color? value) => _color = value;

  DateTime get date => _date;
  set date(DateTime value) => _date = value;

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'type': _type,
      'name': _name,
      'amount': _amount,
      'icon': _icon.codePoint,
      'color': _color?.value,
      'date': _date.toIso8601String(),
    };
  }

  factory Spending.fromJson(Map<String, dynamic> json) {
    return Spending(
      id: (json['id'] as num).toInt(),
      type: json['type'],
      name: json['name'],
      amount: (json['amount'] as num).toInt(),
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      color: json['color'] != null ? Color(json['color']) : null,
      date: DateTime.parse(json['date']),
    );
  }
}
