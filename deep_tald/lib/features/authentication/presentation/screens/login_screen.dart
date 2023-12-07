import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //dependency injection
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 245, 246, 250),
      //QUI CI VA APPBAR QUANDO SARA PRONTA
      body: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    width: 317,
                    child: Text(
                      "Email",
                      style: GoogleFonts.rubik(
                          color: const Color.fromARGB(255, 24, 24, 23),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    )),
                const SizedBox(height: 10),
                CustomTextfield(
                  control: _emailController,
                  hintString: "Inserisci email",
                  isObscureText: false,
                ),
                const SizedBox(height: 35),
                SizedBox(
                    width: 317,
                    child: Text(
                      "Password",
                      style: GoogleFonts.rubik(
                          color: const Color.fromARGB(255, 24, 24, 23),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    )),
                const SizedBox(height: 10),
                CustomTextfield(
                  control: _passwordController,
                  hintString: "Inserisci password",
                  isObscureText: true,
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    Button(
                      buttonText: "Login",
                      onPressed: () async {
                        String email = _emailController.text.trim();
                        String password = _passwordController.text.trim();
                        if (email.isNotEmpty && password.isNotEmpty) {
                          authController.loginWithEmailPassword(
                              email, password);
                          // Ti porta sulla home a perchè c'è un observer in auth controller
                        } else {
                          Get.snackbar(
                            'Campi vuoti',
                            'Compila tutti i campi',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Password dimenticata?",
                      style: GoogleFonts.rubik(
                          color: const Color(0xFF599BFF),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
