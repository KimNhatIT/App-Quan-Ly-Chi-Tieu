class Spending {
  String _id;
  String _title;
  double _amount;
  DateTime _date;

  Spending({
    required String id,
    required String title,
    required double amount,
    required DateTime date,
  }) : _id = id,
       _title = title,
       _amount = amount,
       _date = date;

  String get id => _id;
  set id(String value) => _id = value;

  String get title => _title;
  set title(String value) => _title = value;

  double get amount => _amount;
  set amount(double value) => _amount = value;

  DateTime get date => _date;
  set date(DateTime value) => _date = value;
}
