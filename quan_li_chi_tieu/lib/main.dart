import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/pages/home/home_page.dart';
import 'package:quan_li_chi_tieu/pages/home/splash_page.dart';
import 'package:quan_li_chi_tieu/services/share_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = await ShareService.isLoggedIn();
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? HomePage() : SplashPage(),
    );
  }
}
