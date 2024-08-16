import 'package:get/get.dart';
import 'package:nusainfra/models/expense.dart';
import 'package:nusainfra/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  var expenses = <Expense>[].obs;

  @override
  void onInit() {
    fetchExpenses(); // Fetch initial data
    super.onInit();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> fetchExpenses(
      {int? walletId,
      int? categoryId,
      DateTime? timeStart,
      DateTime? timeEnd}) async {
    final response = await _apiService
        .getData('expense', token: getToken().toString(), queryParams: {
      'wallet_id': walletId?.toString(),
      'category_id': categoryId?.toString(),
      'time_start': timeStart?.toIso8601String(),
      'time_end': timeEnd?.toIso8601String(),
    });

    if (response.statusCode == 200) {
      expenses.value =
          (response.body as List).map((e) => Expense.fromJson(e)).toList();
    } else {
      Get.snackbar('Error', 'Failed to load expenses');
    }
  }

  Future<void> createExpense(int walletId, String name, int categoryId,
      double amount, DateTime time) async {
    final response = await _apiService.postData(
        'wallet/$walletId/expense',
        {
          'name': name,
          'category_id': categoryId,
          'amount': amount.toString(),
          'time': time.toIso8601String(),
        },
        token: await getToken().toString());

    if (response.statusCode == 200) {
      fetchExpenses();
    } else {
      Get.snackbar('Error', 'Failed to create expense');
    }
  }

  Future<void> updateExpense(
      int id, String name, int categoryId, double amount, DateTime time) async {
    final response = await _apiService.postData(
        'expense/$id',
        {
          'name': name,
          'category_id': categoryId,
          'amount': amount.toString(),
          'time': time.toIso8601String(),
        },
        token: await getToken().toString());

    if (response.statusCode == 200) {
      fetchExpenses();
    } else {
      Get.snackbar('Error', 'Failed to update expense');
    }
  }

  Future<void> deleteExpense(int id) async {
    final response =
        await _apiService.postData('expense/$id', {}, token: await getToken().toString());

    if (response.statusCode == 200) {
      fetchExpenses();
    } else {
      Get.snackbar('Error', 'Failed to delete expense');
    }
  }
}
