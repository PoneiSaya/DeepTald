import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import 'package:get/get.dart';
import '../widget/Button.dart';
import '../widget/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  //dependency injection
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextfield(control: _emailController, hintString: "Email"),
            SizedBox(height: 8.0),
            SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 8.0),
            SizedBox(height: 8.0),
            SizedBox(height: 16.0),
            Button(
              buttonText: "Entra",
              onPressed: () async {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();
                if (email.isNotEmpty && password.isNotEmpty) {
                  authController.loginWithEmailPassword(email, password);
                  // Puoi implementare la logica di navigazione o feedback all'utente qui
                } else {
                  Get.snackbar(
                    'Campi vuoti',
                    'Compila tutti i campi',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
