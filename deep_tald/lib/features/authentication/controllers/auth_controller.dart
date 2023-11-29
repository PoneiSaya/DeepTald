import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../model/entity/paziente.dart';
import '../../../routes/routes.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Rx<User?> _user;

  //metodo che viene lanciato appena si avvia l'app
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
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

      _user = Rx<User?>(auth.currentUser);
    } catch (e) {
      print("\n\nECCEZIONE FALLISCE LA REGISTRAZIONE\n\n"); //fare get.snack
      print(e.toString());
    }
  }

  Future<void> loginWithEmailPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
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
}
