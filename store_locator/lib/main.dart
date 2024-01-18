import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/user.login.dart';
import 'pages/customer.signup.dart';
import 'pages/customer.dashboard.dart';
import 'pages/shop.signup.dart';
import 'pages/shop.dashboard.dart';

void main() async {
  dev.log('This is main function');
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(const MyApp(
    token: "jghhhfj", //  prefs.getString('token'),
  ));
}

class MyApp extends StatelessWidget {
  final String token;
  const MyApp({
    required this.token,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const LoginPage(),
        // customer signup page
        '/customer_signup': (context) => const RegisterPage(),
        // shop signup page
        '/shop_signup': (context) => const ShopRegisterPage(),
        // customer dashboard page
        '/customer_dashboard': (context) => CustomerDashboardPage(),

        // (token != null && (JwtDecoder.isExpired(token)) != false)
        //   ? const CustomerDashboardPage();
        //   : const LoginPage());

        // shop dashboard page
        '/shop_dashboard': (context) => ShopDashboard(shopId: "ffdsf"),
        // Only include '/signup' if you create the SignupPage class:
        // '/signup': (context) => RegisterShopPage(),
        // Add routes for other pages as needed
      },
    );
  }
}
