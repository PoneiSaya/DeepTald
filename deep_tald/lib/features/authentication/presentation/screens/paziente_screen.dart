import 'package:deep_tald/features/authentication/controllers/auth_controller.dart';
import 'package:deep_tald/features/authentication/presentation/widget/Card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PazienteScreen extends StatefulWidget {
  const PazienteScreen({Key? key}) : super(key: key);

  @override
  State<PazienteScreen> createState() => _PazienteScreenState();
}

class _PazienteScreenState extends State<PazienteScreen> {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    String? nome = authController.utente?.nome;
    nome ??= "...";
    String? cognome = authController.utente?.cognome;
    cognome ??= "...";

    return MaterialApp(
        home: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: //padding sopra e a sinistra
                EdgeInsets.only(
                    left: 30, top: MediaQuery.of(context).size.height / 9),
            child: Text(
              'Ciao $nome!  \u{1F44B} ',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 35),
          CardDeepTald(
            'assets/images/mindfullness.png',
            'Parla con Bob!',
            'Inizia',
            () {
              // ...
            },
          ),
          CardDeepTald(
            'assets/images/gestire.png',
            'Andamento!',
            'Controlla',
            () {
              // ...
            },
          ),
        ],
      ),
    ));
  }
}
