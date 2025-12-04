class Account {
  String _username;
  String _fullname;
  String _password;
  String _email;

  Account({
    required String username,
    required String fullname,
    required String password,
    required String email,
  }) : _username = username,
       _fullname = fullname,
       _password = password,
       _email = email;

  String get username => _username;
  set username(String value) => _username = value;

  String get fullname => _fullname;
  set fullname(String value) => _fullname = value;

  String get password => _password;
  set password(String value) => _password = value;

  String get email => _email;
  set email(String value) => _email = value;

  Map<String, String> toJson() {
    return {
      'username': _username,
      'fullname': _fullname,
      'password': _password,
      'email': _email,
    };
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      username: json['username'],
      fullname: json['fullname'],
      password: json['password'],
      email: json['email'],
    );
  }
}
