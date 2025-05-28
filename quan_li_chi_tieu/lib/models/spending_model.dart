class SpendingModel {
  String _id;
  String _title;
  double _amount;
  DateTime _date;

  SpendingModel(this._id, this._title, this._amount, this._date);

  // Getters
  String get id => _id;
  String get title => _title;
  double get amount => _amount;
  DateTime get date => _date;

  // Setters
  set id(String value) => _id = value;
  set title(String value) => _title = value;
  set amount(double value) => _amount = value;
  set date(DateTime value) => _date = value;
}
