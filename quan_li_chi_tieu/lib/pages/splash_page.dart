import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Route route = MaterialPageRoute(builder: (context) => const HomePage());
      Navigator.of(
        context,
      ).pushAndRemoveUntil(route, (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(child: Image.asset('assets/images/logo.png')),
    );
  }
}
