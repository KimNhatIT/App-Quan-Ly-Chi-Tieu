import 'dart:convert';

import 'package:quan_li_chi_tieu/models/account.dart';
import 'package:quan_li_chi_tieu/models/spending.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareService {
  // =============*SAVE ACCOUNT*============== //

  static Future<void> saveAccount(Account account) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String jsonString = jsonEncode(account.toJson());
      await prefs.setString('account', jsonString);
    } catch (e) {
      print('Lỗi lưu tài khoản khi tắt app: $e');
    }
  }

  static Future<Account?> getSavedAccount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? jsonString = prefs.getString('account');
      if (jsonString == null) return null;

      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return Account.fromJson(jsonMap);
    } catch (e) {
      print('Lỗi lấy tài khoản đã lưu: $e');
      return null;
    }
  }

  static Future<void> clearSavedAccount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('account');
    } catch (e) {
      print('Lỗi xóa tài khoản đã lưu: $e');
    }
  }

  // =============*SAVE LIST<ACCOUNT>*============== //

  static Future<void> saveAccountList(List<Account> listAccounts) async {
    dynamic prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonList =
        listAccounts.map((Account account) {
          return account.toJson();
        }).toList();
    final String jsonString = jsonEncode(jsonList);
    await prefs.setString('account_list', jsonString);
  }

  static Future<List<Account>> getAccountList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('account_list');
    if (jsonString == null) return [];
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Account.fromJson(json)).toList();
  }

  // =============*SAVE LIST<SPENDING> THEO USERNAME*============== //

  static Future<void> saveUserSpending(
    Map<String, List<Spending>> saveListSpending,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> jsonMap = {};

    saveListSpending.forEach((username, spendings) {
      jsonMap[username] = spendings.map((s) => s.toJson()).toList();
    });

    final String jsonString = jsonEncode(jsonMap);
    await prefs.setString('all_spending_data', jsonString);
  }

  static Future<Map<String, List<Spending>>> getAllUserSpending() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('all_spending_data');

    if (jsonString == null) return {};

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    Map<String, List<Spending>> result = {};

    jsonMap.forEach((username, spendingsJson) {
      List<Spending> spendings =
          (spendingsJson as List)
              .map((json) => Spending.fromJson(json))
              .toList();
      result[username] = spendings;
    });

    return result;
  }

  // =================================== //
}
