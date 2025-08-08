import 'package:flutter/cupertino.dart';
import 'package:bar_stock/features/auth/presentation/login_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: const LoginPage());
  }
}
