import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/entity/paziente.dart';
import '../model/entity/medico.dart';
import '../model/entity/utente.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<Utente?> findUtenteByUserId(String userId) async {
    try {
      // Cerca tra i pazienti
      QuerySnapshot pazientiQuery = await _db
          .collection('Pazienti')
          .where('uid', isEqualTo: userId)
          .get();

      if (pazientiQuery.docs.isNotEmpty) {
        Map pazienteData =
            pazientiQuery.docs.first.data() as Map<String, dynamic>;
        return Paziente(
          pazienteData['Nome'],
          pazienteData['Cognome'],
          pazienteData['CodiceFiscale'],
          pazienteData['Email'],
          pazienteData['Password'],
          pazienteData['DataDiNascita'].toDate(),
        );
      }

      // Se non trovi il paziente, cerca tra i medici
      QuerySnapshot mediciQuery =
          await _db.collection('Medici').where('uid', isEqualTo: userId).get();

      if (mediciQuery.docs.isNotEmpty) {
        Map medicoData = mediciQuery.docs.first.data() as Map<String, dynamic>;
        return Medico(
          medicoData['Nome'],
          medicoData['Cognome'],
          medicoData['CodiceFiscale'],
          medicoData['Email'],
          medicoData['Password'],
          medicoData["DataDiNascita"].toDate(),
        );
      }

      // Se non trovi né paziente né medico, restituisci null
      return null;
    } catch (e) {
      // Gestisci eventuali errori di connessione al database
      print('Errore durante la ricerca dell\'utente per userId: $e');
      return null;
    }
  }

  createPaziente(Paziente paziente) async {
    await _db
        .collection("Pazienti")
        .add(paziente.toJson(null))
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

  createMedico(Medico medico) async {
    await _db
        .collection("Medico")
        .add(medico.toJson(null))
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
