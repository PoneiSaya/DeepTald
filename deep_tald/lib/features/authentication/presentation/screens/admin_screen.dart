import 'dart:convert';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:crypto/crypto.dart';
import 'package:deep_tald/features/authentication/controllers/auth_controller.dart';
import 'package:deep_tald/features/authentication/presentation/widget/Button.dart';
import 'package:deep_tald/features/authentication/presentation/widget/custom_textfield.dart';
import 'package:deep_tald/navbar/navbar_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

bool isAdmin = true;

class _AdminPageState extends State<AdminPage> {
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    final navbarController = Get.put(NavbarController());
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController nomeController = TextEditingController();
    final TextEditingController cognomeController = TextEditingController();
    final TextEditingController codiceFiscaleController =
        TextEditingController();
    DateTime? selectedDate;

    String hashPassword(String password) {
      var hash = sha256.convert(utf8.encode(password));
      String hashedPassword = hash.toString();
      return hashedPassword;
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

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 246, 250),
        body: Column(children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 9),
            child: Text(
              'Aggiungi un utente',
              style: GoogleFonts.rubik(
                  color: const Color.fromARGB(255, 24, 24, 23),
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(height: 10),
          SizedBox(
              child: CustomTextfield(
            control: nomeController,
            hintString: "Inserisci nome",
            isObscureText: false,
          )),
          const SizedBox(height: 10),
          SizedBox(
              child: CustomTextfield(
            control: cognomeController,
            hintString: "Inserisci cognome",
            isObscureText: false,
          )),
          const SizedBox(height: 10),
          SizedBox(
              child: CustomTextfield(
            control: codiceFiscaleController,
            hintString: "Inserisci codice fiscale",
            isObscureText: false,
          )),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text('Seleziona Data di nascita'),
          ),
          const SizedBox(height: 10),
          SizedBox(
              child: CustomTextfield(
            control: emailController,
            hintString: "Inserisci email",
            isObscureText: false,
          )),
          const SizedBox(height: 10),
          SizedBox(
              child: CustomTextfield(
            control: passwordController,
            hintString: "Inserisci password",
            isObscureText: true,
          )),
          Center(
              child: Row(
            children: [
              Text("Medico"),
              FlutterSwitch(
                value: isAdmin,
                onToggle: (value) {
                  setState(() {
                    isAdmin = value;
                  });
                },
              ),
              Text("Admin")
            ],
          )),
          Button(
              buttonText: "Registra",
              onPressed: () async {
                String email = emailController.text.trim();
                String codiceFiscale = codiceFiscaleController.text.trim();
                String password = passwordController.text.trim();
                String nome = nomeController.text.trim();
                String hashedPassword = hashPassword(password);
                String cognome = cognomeController.text.trim();

                authController.registerWithRuolo(nome, cognome, codiceFiscale,
                    email, hashedPassword, selectedDate!, isAdmin);
              })
        ]));
  }
}
