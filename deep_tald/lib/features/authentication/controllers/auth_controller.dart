import 'package:deep_tald/features/authentication/presentation/screens/login_screen.dart';
import 'package:deep_tald/features/authentication/presentation/screens/registration_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../model/entity/paziente.dart';

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
      print("TI SEI LOGGATO");
      //Get.offAll(() => HomePage()); quando avremo una home
    }
  }

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    final Paziente pz =
        Paziente("michele", "arturo", "ELIO", email, password, DateTime.now());
    //try {
    // Registra l'utente con Firebase Authentication
    var result = await auth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((registeredUser) => {
              firestore
                  .collection("usersCollection")
                  .add(pz.toJson(registeredUser.user?.uid))
            });
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
