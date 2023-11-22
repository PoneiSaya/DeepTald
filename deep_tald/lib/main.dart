import 'package:deep_tald/features/authentication/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:deep_tald/features/authentication/screens/auth_controller.dart';
import 'package:deep_tald/repository/paziente_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());
  Get.put(
      PazienteRepository()); // Aggiungi questa riga per registrare PazienteRepository
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Utilizza il widget principale della tua applicazione
      home: RegistrationScreen(),
    );
  }
}
