
import 'package:deep_tald/features/authentication/presentation/screens/initial_screen.dart';
import 'package:deep_tald/features/authentication/presentation/screens/home_screen.dart';
import 'package:deep_tald/features/authentication/presentation/screens/login_screen.dart';
import 'package:deep_tald/features/authentication/presentation/screens/registration_screen.dart';
import 'package:deep_tald/model/entity/medico.dart';
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
    //pensalo come lo stato dell'utente che se cambia hai "notifiche"
    _user.bindStream(auth.userChanges());
    // è un metodo che serve a lanciare il metodo _initialScreen basandosi sullo stato dell'user
    ever(_user, _initialScreen);
  }

  ///metodo privato che fa da route per la prima pagina
  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() =>
          RegistrationScreen()); //se al posto di login metti home ti porta alla home
    } else {
      Get.toNamed(Routes.getHomeRoute()); //quando avremo una home
    }
  }

  Future<void> registerWithEmailAndPassword(
      String nome,
      String cognome,
      String codiceFiscale,
      String email,
      String password,
      DateTime dataDiNascita) async {
    print("sono nel metodo di registrazione");
    try {
      // Registra l'utente con Firebase Authentication
      final Paziente pz = Paziente(
          nome, cognome, codiceFiscale, email, password, dataDiNascita);
      var result = await auth
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
      print("\n\nECCEZIONE FALLISCE LA REGISRRAZIONE\n\n");
      print(e.toString());
    }
  }

  Future<void> loginWithEmailPassword(String email, String password) async {
    try {
      print("password = " + password);
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
    } catch (e) {
      Get.snackbar(
        'Errore nel logout',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
