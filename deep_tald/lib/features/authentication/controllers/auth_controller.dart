import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:deep_tald/features/authentication/presentation/screens/initial_screen.dart';
import 'package:deep_tald/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../model/entity/paziente.dart';
import '../../../routes/routes.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Rx<User?> _user;
  bool isPaziente = false;
  late String nome;
  late String cognome;
  final GetStorage userStorage = GetStorage();

  final UserRepository userRepository = UserRepository();

  String getNome() {
    return nome;
  }

  String getCognome() {
    return cognome;
  }

  //metodo che viene lanciato appena si avvia l'app
  @override
  void onReady() {
    super.onReady();

    //prendi email e password da user storage
    //se c'è un utente loggato allora fai login
    dynamic email = userStorage.read("email");
    dynamic password = userStorage.read("password");
    if (email != null && password != null) {
      loginWithEmailPassword(email, password);
    }

    _user = Rx<User?>(auth.currentUser);
    //pensalo come lo stato dell'utente che se cambia hai "notifiche"
    _user.bindStream(auth.userChanges());
    // è un metodo che serve a lanciare il metodo _initialScreen basandosi sullo stato dell'user
    ever(_user, _initialScreen);
  }

  ///metodo privato che fa da route per la prima pagina
  _initialScreen(User? user) {
    //Cerca nel database se l'utente è nella collection pazienti
    //se si allora vai alla home paziente
    //se no vai alla home medico
    if (user != null) {
      Future<Map> data = userRepository.searchPazientiForUID(user.uid);
      data.then((value) => {
            nome = value["Nome"],
            cognome = value["Cognome"],
            if (value.isNotEmpty)
              {
                Get.offAllNamed(Routes.getHomePazienteRoute()),
              }
            else
              {
                Get.offAllNamed(Routes.getHomeMedicoRoute()),
              }
          });
    } else {
      Get.offAll(() => const InitialScreen());
    }
  }

  String hashPassword(String password) {
    var hash = sha256.convert(utf8.encode(password));
    String hashedPassword = hash.toString();
    return hashedPassword;
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
            password: hashPassword(password),
          )
          .then((registeredUser) => {
                firestore
                    .collection("Pazienti")
                    .add(pz.toJson(registeredUser.user?.uid))
              });

      _user = Rx<User?>(auth.currentUser);
    } catch (e) {
      print("\n\nECCEZIONE FALLISCE LA REGISRRAZIONE\n\n");
      print(e.toString());
    }
  }

  Future<void> loginWithEmailPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email, password: hashPassword(password));
      userStorage.write("email", email);
      userStorage.write("password", password);
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
      userStorage.remove("email");
      userStorage.remove("password");
    } catch (e) {
      Get.snackbar(
        'Errore nel logout',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
