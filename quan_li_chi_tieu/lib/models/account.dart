class Account {
  String _username;
  String _fullname;
  String _password;
  DateTime _birthday;
  String _email;

  Account({
    required String username,
    required String fullname,
    required String password,
    required DateTime birthday,
    required String email,
  }) : _username = username,
       _fullname = fullname,
       _password = password,
       _birthday = birthday,
       _email = email;

  // Getter and Setter for username
  String get username => _username;
  set username(String value) => _username = value;

  // Getter and Setter for fullname
  String get fullname => _fullname;
  set fullname(String value) => _fullname = value;

  // Getter and Setter for password
  String get password => _password;
  set password(String value) => _password = value;

  // Getter and Setter for birthday
  DateTime get birthday => _birthday;
  set birthday(DateTime value) => _birthday = value;

  // Getter and Setter for email
  String get email => _email;
  set email(String value) => _email = value;
}
