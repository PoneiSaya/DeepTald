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
}
