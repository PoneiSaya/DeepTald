import 'package:deep_tald/features/authentication/controllers/auth_controller.dart';
import 'package:deep_tald/features/authentication/presentation/widget/Card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicoScreen extends StatefulWidget {
  const MedicoScreen({Key? key}) : super(key: key);

  @override
  State<MedicoScreen> createState() => _MedicoScreenState();
}

class _MedicoScreenState extends State<MedicoScreen> {
  final int currentPageIndex = 0;
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: //padding sopra e a sinistra
                  EdgeInsets.only(left: 30, top: 30),
              child: Text(
                'Ciao Dr. Lambiase!  \u{1F44B}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  CardDeepTald(
                    'assets/images/mindfullness.png',
                    'Usa IA!',
                    'Inizia',
                    () {
                      // ...
                    },
                  ),
                  CardDeepTald(
                    'assets/images/grafico.png',
                    'Monitora i pazienti!',
                    'Monitora',
                    () {
                      // ...
                    },
                  ),
                  CardDeepTald(
                    'assets/images/gestire.png',
                    'Gestisci i Pazienti!',
                    'Gestisci',
                    () {
                      authController.logout();
                      // ...
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
