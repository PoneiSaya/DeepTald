import 'package:deep_tald/features/authentication/controllers/auth_controller.dart';
import 'package:deep_tald/features/authentication/presentation/widget/Button.dart';
import 'package:deep_tald/features/authentication/presentation/widget/profile_textfield.dart';
import 'package:deep_tald/model/entity/paziente.dart';
import 'package:deep_tald/model/entity/utente.dart';
import 'package:deep_tald/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  UserRepository user = Get.find();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    Utente? u = authController.utente;
    String nome = u?.getNome;
    String cognome = u?.getCognome;
    String codiceFiscale = u?.getCodiceFiscale;
    DateTime dataDiNascita = u?.getDataDiNascita;
    String email = u?.getEmail;
    String password = u?.getPassword;
    return Container(
        child: Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: _height / 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 80,
                        ),
                        Text(
                          'Profilo',
                          style: GoogleFonts.rubik(
                              color: Color.fromARGB(255, 24, 24, 23),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w600,
                              fontSize: 24),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: _height / 2.2),
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _height / 3.5,
                      left: _width / 20,
                      right: _width / 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ProfileField(label: nome),
                                ProfileField(label: cognome),
                                ProfileField(label: codiceFiscale),
                                ProfileField(label: dataDiNascita.toString()),
                                ProfileField(label: email),
                                ProfileField(label: "*********************"),
                                Padding(
                                  padding: EdgeInsets.only(left: 150),
                                  child: Text("Modifica Password",
                                      style: GoogleFonts.rubik(
                                          color: Colors.black,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13)),
                                )
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: ElevatedButton(
                                onPressed: () {
                                  AuthController authController =
                                      AuthController();
                                  authController.logout();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF599BFF),
                                    foregroundColor: Colors.white,
                                    fixedSize: const Size(169, 48)),
                                child: Text(
                                  "Logout",
                                  style: GoogleFonts.rubik(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
