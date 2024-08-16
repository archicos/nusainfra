import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.wallet),
              title: Text('Wallets'),
              onTap: () {
                Get.toNamed('/wallet');
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categories'),
              onTap: () {
                Get.toNamed('/category');
              },
            ),
            ListTile(
              leading: Icon(Icons.money),
              title: Text('Expenses'),
              onTap: () {
                Get.toNamed('/expense');
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.wallet),
            title: Text('Wallets'),
            onTap: () {
              Get.toNamed('/wallet');
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categories'),
            onTap: () {
              Get.toNamed('/category');
            },
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text('Expenses'),
            onTap: () {
              Get.toNamed('/expense');
            },
          ),
        ],
      ),
    );
  }
}
