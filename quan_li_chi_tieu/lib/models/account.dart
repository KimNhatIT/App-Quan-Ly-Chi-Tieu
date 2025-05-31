class Account {
  String _avatar;
  String _username;
  String _fullname;
  String _password;
  String _email;

  Account({
    required String avatar,
    required String username,
    required String fullname,
    required String password,
    required String email,
  }) : _avatar = avatar,
       _username = username,
       _fullname = fullname,
       _password = password,
       _email = email;

  // Getter and Setter for avatar
  String get avatar => _avatar;
  set avatar(String value) => _avatar = value;

  // Getter and Setter for username
  String get username => _username;
  set username(String value) => _username = value;

  // Getter and Setter for fullname
  String get fullname => _fullname;
  set fullname(String value) => _fullname = value;

  // Getter and Setter for password
  String get password => _password;
  set password(String value) => _password = value;

  // Getter and Setter for email
  String get email => _email;
  set email(String value) => _email = value;
}
