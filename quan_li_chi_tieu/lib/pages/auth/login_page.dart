import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/data/accounts_data.dart';
import 'package:quan_li_chi_tieu/models/account.dart';
import 'package:quan_li_chi_tieu/pages/home/home_page.dart';
import 'package:quan_li_chi_tieu/services/share_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text;
    final bool loggedIn = true;

    int count = -1;

    for (Account account in listAccounts) {
      if (account.username == username && account.password == password) {
        count = 0;
        break;
      } else {
        count - 1;
      }
    }
    if (count == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tên đăng nhập hoặc mật khẩu không đúng')),
      );
    } else {
      ShareService.setLoggedIn(loggedIn);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đăng nhập thành công')));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false, // xóa toàn bộ route cũ
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Đăng nhập'),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Tên đăng nhập',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mật khẩu',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _login, child: const Text('Đăng nhập')),
            ],
          ),
        ),
      ),
    );
  }
}
