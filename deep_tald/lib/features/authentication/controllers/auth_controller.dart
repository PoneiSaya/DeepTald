import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:deep_tald/model/entity/admin.dart';
import 'package:deep_tald/model/entity/medico.dart';
import 'package:deep_tald/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../model/entity/paziente.dart';
import '../../../model/entity/utente.dart';
import '../../../navbar/navbar_controller.dart';
import '../../../routes/routes.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserRepository userRepository = UserRepository();
  // ignore: unused_field
  late Rx<User?> _user = Rx<User?>(auth.currentUser);
  Utente? utente;
  NavbarController navbarController = Get.put(NavbarController());

  //metodo che viene lanciato appena si avvia l'app
  @override
  void onReady() async {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    if (auth.currentUser != null) {
      utente = await userRepository.findUtenteByUserId(auth.currentUser!.uid)
          as Utente;
      utente!.setId(auth.currentUser!.uid);
    }
    if (utente != null && auth.currentUser?.displayName == "paziente") {
      //Rebuild all GetX from previous routes
      navbarController.setUpForPaziente();
    } else if (utente != null && auth.currentUser?.displayName == "medico") {
      navbarController.setUpForMedico();
    } else {
      //utente non logato vai alla schermata di login
      Get.toNamed(Routes.initialScreen);
    }
  }

  Future<void> registerWithEmailAndPassword(
      String nome,
      String cognome,
      String codiceFiscale,
      String email,
      String password,
      DateTime dataDiNascita) async {
    try {
      // Registra l'utente con Firebase Authentication
      final Paziente pz = Paziente(
          nome, cognome, codiceFiscale, email, password, dataDiNascita);
      await auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((registeredUser) => {
                firestore
                    .collection("Pazienti")
                    .add(pz.toJson(registeredUser.user?.uid))
              });
      //aggiungi all'user l'attributo displayname medico e paziente
      await auth.currentUser?.updateDisplayName(
          "paziente"); //questo attributo ci indica il ruolo che l'utyente ha nel
      utente = await userRepository.findUtenteByUserId(auth.currentUser!.uid)
          as Utente;
      _user = Rx<User?>(auth.currentUser);
      //usa get storage per memorizzare nome e cognome
    } catch (e) {
      print("\n\nECCEZIONE FALLISCE LA REGISTRAZIONE\n\n"); //fare get.snack
      print(e.toString());
    }
  }

  String hashPassword(String password) {
    var hash = sha256.convert(utf8.encode(password));
    String hashedPassword = hash.toString();
    return hashedPassword;
  }

  Future<void> loginWithEmailPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email, password: hashPassword(password));
      utente = await userRepository.findUtenteByUserId(auth.currentUser!.uid)
          as Utente;
      print(utente);
      //se il display name è medico vai alla home medico
      if (auth.currentUser?.displayName == "medico") {
        navbarController.setUpForMedico();
        Get.toNamed(Routes.navbar);
      } else if (auth.currentUser?.displayName == "paziente") {
        navbarController.setUpForPaziente();
        Get.toNamed(Routes.navbar);
      } else if (auth.currentUser?.displayName == "admin") {
        navbarController.setUpForAdmin();
        Get.toNamed(Routes.navbar);
      } else {
        Get.snackbar(
          'Errore',
          "Non sei registrato",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Errore nel login',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
      Get.toNamed(Routes.initialScreen);
    } catch (e) {
      Get.snackbar(
        'Errore nel logout',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<bool> contollaAutenticazione() async {
    return utente == null;
  }

  /// Permette di registrare un user inserendone anche il ruolo, viene usato nella pagina admin */
  Future<void> registerWithRuolo(
    String nome,
    String cognome,
    String codiceFiscale,
    String email,
    String password,
    DateTime dataDiNascita,
    bool flag,
  ) async {
    /// se flag == true allora registra un admin
    if (flag == true) {
      try {
        final Admin admin =
            Admin(nome, cognome, codiceFiscale, email, password, dataDiNascita);
        await auth
            .createUserWithEmailAndPassword(
              email: email,
              password: password,
            )
            .then((registeredUser) => {
                  firestore
                      .collection("Admin")
                      .add(admin.toJson(registeredUser.user?.uid))
                });
        await auth.currentUser?.updateDisplayName("admin"); //"admin"
      } catch (e) {
        Get.snackbar("Errore", "La registrazione non va a buon fine");
      }
    } else {
      try {
        final Medico admin = Medico(
            nome, cognome, codiceFiscale, email, password, dataDiNascita);
        await auth
            .createUserWithEmailAndPassword(
              email: email,
              password: password,
            )
            .then((registeredUser) => {
                  firestore
                      .collection("Medico")
                      .add(admin.toJson(registeredUser.user?.uid))
                });
        await auth.currentUser?.updateDisplayName("medico"); //ruolo medico
      } catch (e) {
        Get.snackbar("Errore", "La registrazione non va a buon fine");
      }
    }
  }
}
