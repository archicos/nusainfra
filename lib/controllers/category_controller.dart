import 'package:get/get.dart';
import 'package:nusainfra/models/category.dart';
import 'package:nusainfra/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  var categories = <Category>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;
    final response =
        await _apiService.getData('category', token: await getToken().toString());

    if (response.statusCode == 200) {
      categories.value =
          (response.body as List).map((e) => Category.fromJson(e)).toList();
    } else {
      Get.snackbar('Error', 'Failed to load categories');
    }
    isLoading.value = false;
  }

  Future<void> createCategory(String name) async {
    final response = await _apiService.postData('category', {'name': name},
        token: await getToken().toString());

    if (response.statusCode == 200) {
      fetchCategories();
    } else {
      Get.snackbar('Error', 'Failed to create category');
    }
  }

  Future<void> updateCategory(int id, String name) async {
    final response = await _apiService.putData('category/$id', {'name': name},
        token: await getToken().toString());

    if (response.statusCode == 200) {
      fetchCategories();
    } else {
      Get.snackbar('Error', 'Failed to update category');
    }
  }

  Future<void> deleteCategory(int id) async {
    final response =
        await _apiService.deleteData('category/$id', token: await getToken().toString());

    if (response.statusCode == 200) {
      fetchCategories();
    } else {
      Get.snackbar('Error', 'Failed to delete category');
    }
  }
}
