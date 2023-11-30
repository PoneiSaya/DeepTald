import 'package:deep_tald/features/authentication/controllers/auth_controller.dart';
import 'package:deep_tald/features/authentication/presentation/widget/Card.dart';
import 'package:deep_tald/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widget/Button.dart';

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
                  const EdgeInsets.only(left: 30, top: 30),
              child: Text(
                'Ciao $nome $cognome!  \u{1F44B}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Button(
              buttonText: "logout",
              onPressed: () => {authController.logout()},
            ),
            Expanded(
              child: ListView(
                children: [
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
                    'Controlla il tuo Andamento!',
                    'Controlla',
                    () {
                      // ...
                    },
                  ),

                  CardDeepTald(
                    'assets/images/gestire.png',
                    'Prova Logout!',
                    'LogOut',
                    //logout
                    () {
                      Get.toNamed(Routes.getProfileRoute());
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
