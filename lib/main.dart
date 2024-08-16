import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nusainfra/controllers/auth_controller.dart';
import 'package:nusainfra/controllers/category_controller.dart';
import 'package:nusainfra/controllers/expense_controller.dart';
import 'package:nusainfra/controllers/wallet_controller.dart';
import 'package:nusainfra/routes.dart';
import 'package:nusainfra/services/api_service.dart';

void main() {
  Get.put(ApiService());
  Get.put(AuthController());
  Get.put(CategoryController());
  Get.put(ExpenseController());
  Get.put(WalletController());
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Expense Tracker',
      initialRoute: '/',
      getPages: AppRoutes.routes,
    );
  }
}
