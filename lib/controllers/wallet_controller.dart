import 'package:get/get.dart';
import 'package:nusainfra/models/wallet.dart';
import 'package:nusainfra/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  var wallets = <Wallet>[].obs;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> fetchWallets() async {
    final response =
        await _apiService.getData('wallet', token: await getToken().toString());

    if (response.statusCode == 200) {
      wallets.value =
          (response.body as List).map((e) => Wallet.fromJson(e)).toList();
    } else {
      Get.snackbar('Error', 'Failed to load wallets');
    }
  }

  Future<void> createWallet(String name) async {
    final response = await _apiService.postData('wallet', {'name': name},
        token: await getToken().toString());

    if (response.statusCode == 200) {
      fetchWallets();
    } else {
      Get.snackbar('Error', 'Failed to create wallet');
    }
  }

  Future<void> updateWallet(int id, String name) async {
    final response = await _apiService.putData('wallet/$id', {'name': name},
        token: await getToken().toString());

    if (response.statusCode == 200) {
      fetchWallets();
    } else {
      Get.snackbar('Error', 'Failed to update wallet');
    }
  }

  Future<void> deleteWallet(int id) async {
    final response =
        await _apiService.deleteData('wallet/$id', token: await getToken().toString());

    if (response.statusCode == 200) {
      fetchWallets();
    } else {
      Get.snackbar('Error', 'Failed to delete wallet');
    }
  }
}
