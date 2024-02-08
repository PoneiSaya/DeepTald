import 'package:deep_tald/features/authentication/controllers/auth_controller.dart';
import 'package:deep_tald/features/authentication/presentation/widget/Card.dart';
import 'package:deep_tald/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 245, 246, 250),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: //padding sopra e a sinistra
                    EdgeInsets.only(
                        left: 30, top: MediaQuery.of(context).size.height / 9),
                child: Text(
                  'Ciao $nome!  \u{1F44B} ',
                  style: GoogleFonts.rubik(
                      color: const Color.fromARGB(255, 24, 24, 23),
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 35),
              CardDeepTald(
                  'assets/images/mindfullness.png', 'Parla con Bob!', 'Inizia',
                  () {
                Get.toNamed(Routes.chatbot);
              }),
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
