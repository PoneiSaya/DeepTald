import 'package:deep_tald/features/authentication/controllers/auth_controller.dart';
import 'package:deep_tald/features/authentication/presentation/widget/Button.dart';
import 'package:deep_tald/features/authentication/presentation/widget/profile_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profilo'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nome",
              style: GoogleFonts.rubik(
                  color: const Color.fromARGB(255, 24, 24, 23),
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ProfileField(label: 'Nome'),
            ),
            Text(
              "Cognome",
              style: GoogleFonts.rubik(
                  color: const Color.fromARGB(255, 24, 24, 23),
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            const Expanded(
              child: ProfileField(label: 'Cognome'),
            ),
            Text(
              "Codice Fiscale",
              style: GoogleFonts.rubik(
                  color: const Color.fromARGB(255, 24, 24, 23),
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ProfileField(label: 'Codice Fiscale'),
            ),
            Text(
              "Data di nascita",
              style: GoogleFonts.rubik(
                  color: const Color.fromARGB(255, 24, 24, 23),
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ProfileField(label: 'Data di nascita'),
            ),
            Text(
              "Email",
              style: GoogleFonts.rubik(
                  color: const Color.fromARGB(255, 24, 24, 23),
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ProfileField(label: 'Email'),
            ),
            Text(
              "Password",
              style: GoogleFonts.rubik(
                  color: const Color.fromARGB(255, 24, 24, 23),
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ProfileField(label: 'Password'),
            ),
            Align(
                alignment: Alignment.center,
                child: Button(
                    buttonText: "Logout",
                    onPressed: () {
                      final AuthController authController = Get.find();
                      authController.logout();
                    }))
          ],
        ),
      ),
    );
  }
}
