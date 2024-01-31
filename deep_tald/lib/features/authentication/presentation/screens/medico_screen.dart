import 'package:deep_tald/features/authentication/controllers/auth_controller.dart';
import 'package:deep_tald/features/authentication/presentation/widget/Card.dart';
import 'package:deep_tald/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: //padding sopra e a sinistra
                  const EdgeInsets.only(left: 30, top: 30),
              child: Text(
                'Ciao Dr. Lambiase!  \u{1F44B}',
                style: GoogleFonts.rubik(
                    color: const Color.fromARGB(255, 24, 24, 23),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
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
                      Get.toNamed(Routes.getMedicoIa());
                    },
                  ),
                  CardDeepTald(
                    'assets/images/grafico.png',
                    'Monitora i pazienti!',
                    'Monitora',
                    () {
                      Get.toNamed(Routes.getMonitoraPazientiPage());
                    },
                  ),
                  CardDeepTald(
                    'assets/images/gestire.png',
                    'Gestisci i Pazienti!',
                    'Gestisci',
                    () {
                      Get.toNamed(Routes.gestionePazientiPage());
                      //authController.logout();
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
