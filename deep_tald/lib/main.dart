import 'package:deep_tald/features/authentication/presentation/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './routes/routes.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:deep_tald/features/authentication/controllers/auth_controller.dart';
import 'package:deep_tald/repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthController())); //Get.put è dependency injection

  Get.put(
      UserRepository()); // Aggiungi questa riga per registrare PazienteRepository
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
      initialRoute: Routes.getRegistrationRoute(),
      getPages: Routes
          .routes, //anzichè regitration dovremo mettere una gif che carica
    );
  }
}
