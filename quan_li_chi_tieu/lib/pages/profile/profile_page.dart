import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/components/drawer_menu.dart';
import 'package:quan_li_chi_tieu/models/account.dart';

class ProfilePage extends StatelessWidget {
  final Account? account;

  const ProfilePage({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thông tin cá nhân')),
      drawer: DrawerMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.account_circle, size: 100, color: Colors.blue),
            Text(
              account?.username ?? 'Error',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                const SizedBox(width: 10),
                Icon(Icons.person, size: 30, color: Colors.blue),
                Text(
                  ' : ${account?.fullname ?? 'Error'}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 10),
                Icon(Icons.email, size: 30, color: Colors.blue),
                Text(
                  ' : ${account?.email ?? 'Error'}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
