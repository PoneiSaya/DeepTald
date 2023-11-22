import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> registerWithEmailAndPassword(
      String email, String password, String nome, String cognome) async {
    try {
      // Registra l'utente con Firebase Authentication
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Aggiungi l'utente al database Firestore
      await firestore.collection('utenti').doc(result.user!.uid).set({
        'email': email,
        'nome': nome,
        'cognome': cognome,
      });
    } catch (e) {
      Get.snackbar(
        'Errore durante la registrazione',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
