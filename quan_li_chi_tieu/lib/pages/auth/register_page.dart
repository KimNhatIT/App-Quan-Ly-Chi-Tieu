import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/data/accounts_data.dart';
import 'package:quan_li_chi_tieu/models/account.dart';
import 'package:quan_li_chi_tieu/pages/auth/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();

  void _register() {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();
    final String email = _emailController.text.trim();
    final String fullname = _fullnameController.text.trim();

    if (username.isEmpty ||
        password.isEmpty ||
        email.isEmpty ||
        fullname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
      );
      return;
    }

    for (Account account in listAccounts) {
      if (account.username == username) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tên đăng nhập đã tồn tại')),
        );
        return;
      }
    }

    Account newAccount = Account(
      avatar: 'avatar1.jpg',
      username: username,
      fullname: fullname,
      password: password,
      email: email,
    );

    listAccounts.add(newAccount);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đăng ký thành công')));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Đăng ký'),
              const SizedBox(height: 20),
              TextField(
                controller: _fullnameController,
                decoration: const InputDecoration(
                  labelText: 'Họ và tên',
                  border: OutlineInputBorder(),
                ),
              ),
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
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
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
              ElevatedButton(
                onPressed: _register,
                child: const Text('Đăng ký'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
