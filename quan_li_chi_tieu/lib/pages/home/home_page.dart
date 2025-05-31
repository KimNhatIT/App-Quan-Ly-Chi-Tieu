import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/pages/home/splash_page.dart';
import 'package:quan_li_chi_tieu/services/share_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _logout() {
    ShareService.clearLoggedIn();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đăng xuất thành công')));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SplashPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: _logout, icon: Icon(Icons.logout)),
            Text('Quản lý chi tiêu'),
            IconButton(onPressed: () {}, icon: Icon(Icons.person)),
          ],
        ),
      ),
    );
  }
}
