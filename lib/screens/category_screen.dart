import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nusainfra/controllers/category_controller.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryController _categoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Obx(() {
        if (_categoryController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (_categoryController.categories.isEmpty) {
          return Center(child: Text('No categories available'));
        }

        return ListView.builder(
          itemCount: _categoryController.categories.length,
          itemBuilder: (context, index) {
            final category = _categoryController.categories[index];
            return ListTile(
              title: Text(category.name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _showEditCategoryDialog(
                          context, category.id, category.name);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _categoryController.deleteCategory(category.id);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateCategoryDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showCreateCategoryDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Category'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Category Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _categoryController.createCategory(nameController.text);
                Get.back();
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _showEditCategoryDialog(
      BuildContext context, int id, String currentName) {
    final TextEditingController nameController =
        TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Category'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Category Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _categoryController.updateCategory(id, nameController.text);
                Get.back();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
