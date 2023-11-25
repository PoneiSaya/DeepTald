import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:deep_tald/features/authentication/controllers/auth_controller.dart';
import 'package:deep_tald/features/authentication/presentation/widget/Button.dart';
import 'package:deep_tald/features/authentication/presentation/widget/custom_textfield.dart';
import 'package:deep_tald/model/entity/paziente.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:deep_tald/repository/user_repository.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatefulWidget {
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
    return Column(
      children: [
        CustomTextfield(control: nomeController, hintString: "Nome"),
        CustomTextfield(control: cognomeController, hintString: "Cognome"),
        Button(
          onPressed: () => _goToNextStep(),
          buttonText: 'Avanti',
        ),
      ],
    );
  }

  Widget _buildStep2(BuildContext context) {
    return Column(
      children: [
        Text('Data di Nascita:'),
        ElevatedButton(
          onPressed: () => _selectDate(context),
          child: Text('Seleziona Data'),
        ),
        CustomTextfield(
            control: codiceFiscaleController, hintString: "Codice fiscale"),
        Button(
          onPressed: () => _goToNextStep(),
          buttonText: 'Avanti',
        ),
      ],
    );
  }

  Widget _buildStep3(BuildContext context) {
    return Column(
      children: [
        CustomTextfield(control: emailController, hintString: "Email"),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        Button(
          onPressed: () async {
            String email = emailController.text.trim();
            String codiceFiscale = codiceFiscaleController.text.trim();
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
              //bool isEmailTaken = await userRepository.isEmailTaken(email);
              bool isCodiceFiscaleTaken =
                  await user.isCodiceFiscaleTaken(codiceFiscale);
              if (isCodiceFiscaleTaken) {
                Get.snackbar(
                  'Codice Fiscale già registrato',
                  'Questo Codice Fiscale è già associato a un account.',
                  snackPosition: SnackPosition.BOTTOM,
                );
                return;
              }
              // Crea un'istanza di Paziente
              Paziente paziente = Paziente(nome, cognome, codiceFiscale, email,
                  hashedPassword, selectedDate!);
              // Chiamare il metodo di registrazione del repository Paziente
              //await userRepository.createPaziente(paziente);
              await authController.registerWithEmailAndPassword(nome, cognome,
                  codiceFiscale, email, hashedPassword, selectedDate!);
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
    );
  }
}
