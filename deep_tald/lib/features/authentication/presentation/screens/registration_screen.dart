import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:deep_tald/features/authentication/controllers/auth_controller.dart';
import 'package:deep_tald/features/authentication/presentation/widget/Button.dart';
import 'package:deep_tald/features/authentication/presentation/widget/Tab.dart';
import 'package:deep_tald/features/authentication/presentation/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:deep_tald/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../routes/routes.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final AuthController authController = Get.find();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cognomeController = TextEditingController();
  final PageController pageController = PageController();
  final TextEditingController codiceFiscaleController = TextEditingController();
  DateTime? selectedDate;
  int currentStep = 0;

  final UserRepository user = UserRepository();

  void _goToNextStep() {
    setState(() {
      currentStep += 1;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
  }

  static bool isValidEmail(String email) {
    RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (emailRegex.hasMatch(email)) {
      return true;
    }
    Get.snackbar('Email non rispetta il formato corretto', 'Reinserisci',
        snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  static bool isValidCodiceFiscale(String codiceFiscale) {
    RegExp codiceFiscaleRegex = RegExp(
        r'^[A-Z]{6}[A-Z0-9]{2}[A-Z][A-Z0-9]{2}[A-Z][A-Z0-9]{3}[A-Z]$',
        caseSensitive: true);
    if (codiceFiscaleRegex.hasMatch(codiceFiscale)) {
      return true;
    }
    Get.snackbar(
        'Il codice fiscale non rispetta il formato corretto', 'Reinserisci',
        snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  String hashPassword(String password) {
    var hash = sha256.convert(utf8.encode(password));
    String hashedPassword = hash.toString();
    return hashedPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildStep(context),
    );
  }

  Widget _buildStep(BuildContext context) {
    switch (currentStep) {
      case 0:
        return _buildStep1(context);
      case 1:
        return _buildStep2(context);
      case 2:
        return _buildStep3(context);
      default:
        return Container(); // Handle other cases if necessary
    }
  }

  Widget _buildStep1(BuildContext context) {
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
                Padding(
                  padding: const EdgeInsets.only(right: 80, bottom: 30),
                  child: Text(
                    "Come ti chiami?",
                    style: GoogleFonts.rubik(
                        color: const Color.fromARGB(255, 24, 24, 23),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w600,
                        fontSize: 30),
                  ),
                ),
                SizedBox(
                    width: 317,
                    child: Text(
                      "Nome",
                      style: GoogleFonts.rubik(
                          color: const Color.fromARGB(255, 24, 24, 23),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    )),
                const SizedBox(height: 10),
                CustomTextfield(
                  control: nomeController,
                  hintString: "Inserisci nome",
                  isObscureText: false,
                ),
                const SizedBox(height: 35),
                SizedBox(
                    width: 317,
                    child: Text(
                      "Cognome",
                      style: GoogleFonts.rubik(
                          color: const Color.fromARGB(255, 24, 24, 23),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    )),
                const SizedBox(height: 10),
                CustomTextfield(
                  control: cognomeController,
                  hintString: "Inserisci password",
                  isObscureText: false,
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    Button(
                      onPressed: () {
                        String nome = nomeController.text.trim();
                        String cognome = cognomeController.text.trim();
                        if (nome.isNotEmpty && cognome.isNotEmpty) {
                          _goToNextStep();
                        } else {
                          Get.snackbar(
                            'Campi vuoti',
                            'Compila tutti i campi',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      buttonText: 'Avanti',
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildStep2(BuildContext context) {
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
                Padding(
                  padding: const EdgeInsets.only(right: 80, bottom: 30),
                  child: Text(
                    "Dati personali",
                    style: GoogleFonts.rubik(
                        color: const Color.fromARGB(255, 24, 24, 23),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w600,
                        fontSize: 30),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Seleziona Data di nascita'),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 35),
                SizedBox(
                    width: 317,
                    child: Text(
                      "Codice fiscale",
                      style: GoogleFonts.rubik(
                          color: const Color.fromARGB(255, 24, 24, 23),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    )),
                const SizedBox(height: 10),
                CustomTextfield(
                  control: codiceFiscaleController,
                  hintString: "Inserisci codice fiscale",
                  isObscureText: false,
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    Button(
                      onPressed: () async {
                        String codiceFiscale =
                            codiceFiscaleController.text.trim();
                        if (codiceFiscale.isNotEmpty &&
                            selectedDate != null &&
                            isValidCodiceFiscale(codiceFiscale)) {
                          bool isCodiceFiscaleTaken =
                              await user.isCodiceFiscaleTaken(codiceFiscale);
                          if (isCodiceFiscaleTaken) {
                            Get.snackbar(
                              'Codice fiscale già in uso',
                              'Ricompila',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            currentStep = currentStep - 1;
                          }
                          _goToNextStep();
                        } else {
                          Get.snackbar(
                            'Campi vuoti',
                            'Compila tutti i campi',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      buttonText: 'Avanti',
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildStep3(BuildContext context) {
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
                Padding(
                  padding: const EdgeInsets.only(right: 80, bottom: 30),
                  child: Text(
                    "Credenziali",
                    style: GoogleFonts.rubik(
                        color: const Color.fromARGB(255, 24, 24, 23),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w600,
                        fontSize: 30),
                  ),
                ),
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
                  control: emailController,
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
                  control: passwordController,
                  hintString: "Inserisci password",
                  isObscureText: true,
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    Button(
                      onPressed: () async {
                        String email = emailController.text.trim();
                        String codiceFiscale =
                            codiceFiscaleController.text.trim();
                        String password = passwordController.text.trim();
                        String nome = nomeController.text.trim();
                        String hashedPassword = hashPassword(password);
                        String cognome = cognomeController.text.trim();

                        if (email.isNotEmpty &&
                            nome.isNotEmpty &&
                            cognome.isNotEmpty &&
                            codiceFiscale.isNotEmpty &&
                            password.isNotEmpty &&
                            selectedDate != null &&
                            isValidEmail(email) &&
                            isValidCodiceFiscale(codiceFiscale)) {
                          bool isEmailPresent = await user.isEmailTaken(email);
                          if (isEmailPresent) {
                            Get.snackbar(
                              'Email già in uso',
                              'Ricompila',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            currentStep = currentStep - 1;

                            return;
                          }
                          await authController.registerWithEmailAndPassword(
                            nome,
                            cognome,
                            codiceFiscale,
                            email,
                            hashedPassword,
                            selectedDate!,
                          );

                          Get.toNamed(Routes.getNavbar());
                        } else {
                          Get.snackbar(
                            'Campi vuoti',
                            'Compila tutti i campi',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      buttonText: 'Registrati',
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
