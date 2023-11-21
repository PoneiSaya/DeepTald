import 'package:deep_tald/features/authentication/screens/registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deep_tald/features/authentication/screens/auth_controller.dart'; // Assicurati che il percorso sia corretto

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding
      .ensureInitialized(); // Necessario per inizializzare alcuni servizi prima dell'esecuzione dell'app
  Get.put(AuthController()); // Inizializza e registra il tuo AuthController
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
      home:
          Registrazione(), // Utilizza il widget principale della tua applicazione
    );
  }
}
