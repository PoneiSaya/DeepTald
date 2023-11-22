import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:deep_tald/features/authentication/model/entities/paziente.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';
import 'package:deep_tald/repository/paziente_repository.dart';

class RegistrationScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final PazienteRepository pazienteRepository = Get
      .find(); // Aggiungi questa linea per ottenere l'istanza di PazienteRepository

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cognomeController = TextEditingController();
  final TextEditingController codiceFiscaleController = TextEditingController();
  DateTime?
      selectedDate; // Aggiunto per tenere traccia della data di nascita selezionata

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      // La data è stata selezionata
      selectedDate = picked;
    }
  }

  static bool isValidEmail(String email) {
    // Espressione regolare per verificare il formato dell'email
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
    // Espressione regolare per verificare il formato del codice fiscale italiano
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
    // Crea un oggetto SHA-256
    var hash = sha256.convert(utf8.encode(password));

    // Converte l'hash in una stringa esadecimale
    String hashedPassword = hash.toString();

    return hashedPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrazione'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: cognomeController,
              decoration: InputDecoration(labelText: 'Cognome'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: codiceFiscaleController,
              decoration: InputDecoration(labelText: 'Codice Fiscale'),
            ),
            SizedBox(height: 8.0),
            SizedBox(height: 8.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 8.0),
            SizedBox(height: 8.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 8.0),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text('Data di Nascita:'),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Seleziona Data'),
                ),
                SizedBox(width: 8.0),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
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
                  bool isEmailTaken =
                      await pazienteRepository.isEmailTaken(email);
                  bool isCodiceFiscaleTaken = await pazienteRepository
                      .isCodiceFiscaleTaken(codiceFiscale);

                  if (isEmailTaken) {
                    Get.snackbar(
                      'Email già registrata',
                      'Questa email è già associata a un account.',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }

                  if (isCodiceFiscaleTaken) {
                    Get.snackbar(
                      'Codice Fiscale già registrato',
                      'Questo Codice Fiscale è già associato a un account.',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }
                  // Crea un'istanza di Paziente
                  Paziente paziente = Paziente(nome, cognome, codiceFiscale,
                      email, hashedPassword, selectedDate!);

                  // Chiamare il metodo di registrazione del repository Paziente
                  await pazienteRepository.createPaziente(paziente);

                  // Puoi implementare la logica di navigazione o feedback all'utente qui
                } else {
                  Get.snackbar(
                    'Campi vuoti',
                    'Compila tutti i campi',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: Text('Registrati'),
            ),
          ],
        ),
      ),
    );
  }
}
