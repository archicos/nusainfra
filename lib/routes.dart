import 'package:get/get.dart';
import 'package:nusainfra/screens/login_screen.dart';
import 'package:nusainfra/screens/register_screen.dart';
import 'package:nusainfra/screens/home_screen.dart';
import 'package:nusainfra/screens/wallet_screen.dart';
import 'package:nusainfra/screens/expense_screen.dart';
import 'package:nusainfra/screens/category_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => LoginScreen()),
    GetPage(name: '/register', page: () => RegisterScreen()),
    GetPage(name: '/home', page: () => HomeScreen()),
    GetPage(name: '/wallet', page: () => WalletScreen()),
    GetPage(name: '/expense', page: () => ExpenseScreen()),
    GetPage(name: '/category', page: () => CategoryScreen()),
  ];
}
