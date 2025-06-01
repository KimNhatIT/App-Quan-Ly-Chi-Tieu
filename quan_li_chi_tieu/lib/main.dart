import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quan_li_chi_tieu/models/account.dart';
import 'package:quan_li_chi_tieu/pages/home/home_page.dart';
import 'package:quan_li_chi_tieu/pages/home/splash_page.dart';
import 'package:quan_li_chi_tieu/services/share_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Bắt buộc khi dùng SystemChrome
  // Chỉ cho phép chế độ dọc
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  WidgetsFlutterBinding.ensureInitialized();
  Account? account = await ShareService.getSavedAccount();
  if (account != null) {
    bool isLoggedIn = true;
    runApp(MyApp(isLoggedIn: isLoggedIn));
  } else {
    bool isLoggedIn = false;
    runApp(MyApp(isLoggedIn: isLoggedIn));
  }
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
