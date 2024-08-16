import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nusainfra/controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController _authController = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _authController.login(
                  emailController.text,
                  passwordController.text,
                );
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () => Get.toNamed('/register'),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
