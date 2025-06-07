import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/components/drawer_menu.dart';
import 'package:quan_li_chi_tieu/data/accounts_data.dart';
import 'package:quan_li_chi_tieu/models/account.dart';
import 'package:quan_li_chi_tieu/services/share_service.dart';

class ChangePassword extends StatefulWidget {
  final Account? accountNow;

  const ChangePassword({super.key, required this.accountNow});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmNewPassword = true;

  void _getallAccount() async {
    List<Account> data = await ShareService.getAccountList();
    setState(() {
      listAccounts = data;
    });
  }

  void _changePassword() {
    final String oldPassword = _oldPasswordController.text;
    final String newPassword = _newPasswordController.text;
    final String confirmNewPassword = _confirmNewPasswordController.text;

    if (oldPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmNewPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
      );
      return;
    } else if (newPassword != confirmNewPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Mật khẩu mới không khớp')));
      return;
    } else if (oldPassword != widget.accountNow!.password) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Mật khẩu cũ không đúng')));
      return;
    } else if (newPassword == widget.accountNow!.password) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mật khẩu mới không được trùng với mật khẩu cũ'),
        ),
      );
      return;
    } else if (newPassword.length < 8 || confirmNewPassword.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu phải có ít nhất 8 kí tự')),
      );
      return;
    }

    for (int i = 0; i < listAccounts.length; i++) {
      if (listAccounts[i].username == widget.accountNow!.username) {
        listAccounts[i].password = newPassword;
      }
    }

    ShareService.saveAccountList(listAccounts);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đổi mật khẩu thành công')));

    _confirmNewPasswordController.clear();
    _newPasswordController.clear();
    _oldPasswordController.clear();
  }

  @override
  void initState() {
    super.initState();
    // Initialize any necessary data or state here
    _getallAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đổi mật khẩu')),
      drawer: DrawerMenu(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _oldPasswordController,
              obscureText: _obscureOldPassword,
              decoration: InputDecoration(
                labelText: 'Mật khẩu cũ',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureOldPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureOldPassword = !_obscureOldPassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _newPasswordController,
              obscureText: _obscureNewPassword,
              decoration: InputDecoration(
                labelText: 'Mật khẩu mới',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureNewPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureNewPassword = !_obscureNewPassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _confirmNewPasswordController,
              obscureText: _obscureConfirmNewPassword,
              decoration: InputDecoration(
                labelText: 'Nhập lại mật khẩu mới',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmNewPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmNewPassword = !_obscureConfirmNewPassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePassword,
              child: const Text('Đổi mật khẩu'),
            ),
          ],
        ),
      ),
    );
  }
}
