import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../features/authentication/model/entities/paziente.dart';

class PazienteRepository extends GetxController {
  static PazienteRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createPaziente(Paziente paziente) async {
    await _db
        .collection("Pazienti")
        .add(paziente.toJson())
        .whenComplete(() => Get.snackbar("Success", "Tutto ok",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.green))
        .catchError((error, stackTrace) {
      Get.snackbar("Errore", "Ops",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.red);
      print(error.toString());
    });
  }

  Future<bool> isEmailTaken(String email) async {
    try {
      // Esegui una query nel database per trovare un paziente con la stessa email
      QuerySnapshot query = await _db
          .collection('Pazienti')
          .where('Email', isEqualTo: email)
          .get();

      // Restituisci true se c'è almeno una corrispondenza
      return query.docs.isNotEmpty;
    } catch (e) {
      // Gestisci eventuali errori di connessione al database
      print('Errore durante la verifica dell\'email: $e');
      return true; // Assume un errore per evitare falsi positivi
    }
  }

  Future<bool> isCodiceFiscaleTaken(String codiceFiscale) async {
    try {
      // Esegui una query nel database per trovare un paziente con lo stesso codice fiscale
      QuerySnapshot query = await _db
          .collection('Pazienti')
          .where('CodiceFiscale', isEqualTo: codiceFiscale)
          .get();

      // Restituisci true se c'è almeno una corrispondenza
      return query.docs.isNotEmpty;
    } catch (e) {
      // Gestisci eventuali errori di connessione al database
      print('Errore durante la verifica del codice fiscale: $e');
      return true; // Assume un errore per evitare falsi positivi
    }
  }
}
