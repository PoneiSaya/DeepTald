import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/entity/paziente.dart';
import '../model/entity/utente.dart';

class ReportRepository extends GetxController {
  static ReportRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<Utente?> findReportsByUserId(String userId) async {
    try {
      print("sono nel metodo findReports");

      QuerySnapshot query = await _db
          .collection('Report')
          .where('uid_pazient', isEqualTo: userId)
          .get();

      if (query.docs.isNotEmpty) {
        print("il opaziente ha dei report");
        //Map reportsData = query.docs.first.data() as Map<String, dynamic>;
      }
    } catch (e) {
      Get.snackbar("Errore", "Errore nella ricerca dei report");
    }
  }
}
