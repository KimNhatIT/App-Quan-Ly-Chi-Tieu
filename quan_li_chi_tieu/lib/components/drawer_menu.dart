import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/models/account.dart';
import 'package:quan_li_chi_tieu/pages/home/home_page.dart';
import 'package:quan_li_chi_tieu/pages/home/splash_page.dart';
import 'package:quan_li_chi_tieu/pages/profile/change_password.dart';
import 'package:quan_li_chi_tieu/pages/profile/profile_page.dart';
import 'package:quan_li_chi_tieu/services/share_service.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  Account? _account;

  Future<void> getInfoUser() async {
    Account? account = await ShareService.getSavedAccount();
    if (account != null) {
      setState(() {
        _account = account;
      });
    }
  }

  void _navigateToProfile() {
    if (_account != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage(account: _account)),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Bạn chưa đăng nhập')));
    }
  }

  void _logout() {
    ShareService.clearSavedAccount();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đăng xuất thành công')));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SplashPage()),
    );
  }

  void _navigateToChangePassword() {
    if (_account != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChangePassword(accountNow: _account),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Bạn chưa đăng nhập')));
    }
  }

  @override
  void initState() {
    super.initState();
    getInfoUser();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.account_circle, size: 80, color: Colors.white),
                Text(
                  _account?.fullname ?? 'Error',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Trang chủ'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Thông tin cá nhân'),
            onTap: _navigateToProfile,
          ),
          ListTile(
            leading: const Icon(Icons.lock_open),
            title: const Text('Đổi mật khẩu'),
            onTap: _navigateToChangePassword,
          ),
          Expanded(child: Container()),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Đăng xuất'),
            onTap: _logout,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
