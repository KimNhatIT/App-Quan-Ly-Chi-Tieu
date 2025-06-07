import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu/pages/auth/login_page.dart';
import 'package:quan_li_chi_tieu/pages/auth/register_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _showButtons = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showButtons = true;
      });
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Logo animation
          TweenAnimationBuilder<Offset>(
            tween: Tween<Offset>(
              begin: const Offset(0, 0),
              end: _showButtons ? const Offset(0, -0.2) : const Offset(0, 0),
            ),
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
            builder: (context, offset, child) {
              return FractionalTranslation(translation: offset, child: child);
            },
            child: Image.asset('assets/images/logo_app.png'),
          ),
          // Buttons slide up from bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 80,
            child: TweenAnimationBuilder<Offset>(
              tween: Tween<Offset>(
                begin: const Offset(0, 2), // Start well below the screen
                end: _showButtons ? const Offset(0, 0) : const Offset(0, 2),
              ),
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
              builder: (context, offset, child) {
                return FractionalTranslation(translation: offset, child: child);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: const Text('Đăng nhập'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text('Đăng ký'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
