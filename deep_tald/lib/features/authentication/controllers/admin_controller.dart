
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_tald/features/authentication/presentation/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AdminController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Rx<User?> _admin;

  //metodo che viene lanciato appena si avvia l'app
  @override
  void onReady() {
    super.onReady();
    _admin = Rx<User?>(auth.currentUser);
    //pensalo come lo stato dell'utente che se cambia hai "notifiche"
    _admin.bindStream(auth.userChanges());
    // è un metodo che serve a lanciare il metodo _initialScreen basandosi sullo stato dell'user
    ever(_admin, _initialScreen);
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

  getAllPazienti(){
    firestore
      .collection("Pazienti")
      .get()
      .then(
        (QuerySnapshot querySnapshot){
           querySnapshot.docs.forEach((doc) {
            print(doc["Nome"]);
          });
        });
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