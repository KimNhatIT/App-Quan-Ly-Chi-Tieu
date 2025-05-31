import 'package:quan_li_chi_tieu/data/accounts_data.dart';
import 'package:quan_li_chi_tieu/models/account.dart';

bool checkLogin(String username, String password) {
  bool check = false;
  for (Account account in listAccounts) {
    if (account.username == username.trim() && account.password == password) {
      return check = true;
    } else {
      continue;
    }
  }
  return check;
}
