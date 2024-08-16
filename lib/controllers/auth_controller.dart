import 'dart:convert';

import 'package:get/get.dart';
import 'package:nusainfra/services/api_service.dart';
import 'package:nusainfra/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  var user = Rxn<User>();
  var isAuthenticated = false.obs;

  Future<void> login(String email, String password) async {
    final response = await _apiService.postData('login', {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final userData = data['user'];
      final token = data['token'];

      user.value = User.fromJson(userData, token: token);
      isAuthenticated.value = true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      Get.offAllNamed('/home');
    } else {
      Get.snackbar('Error', 'Login failed: ${response.body}');
    }
  }

  Future<void> register(String name, String email, String password,
      String passwordConfirmation) async {
    final response = await _apiService.postData('register', {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });

    if (response.statusCode == 200) {
      Get.offAllNamed('/login');
    } else {
      Get.snackbar('Error', 'Registration failed: ${response.body}');
    }
  }

  void logout() {
    user.value = null;
    isAuthenticated.value = false;
    Get.offAllNamed('/login');
  }
}
