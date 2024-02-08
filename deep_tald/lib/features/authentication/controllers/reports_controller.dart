import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_tald/model/entity/report.dart';
import 'package:deep_tald/repository/report_repository.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Report>> findReportsByUserId(String userId) async {
    try {
      List<Report> resultList = List.empty(growable: true);

      print("sono nel metodo findReports con userID = " + userId);
      QuerySnapshot query = await firestore
          .collection('Report')
          .where('uid_paziente', isEqualTo: userId)
          .get();

      if (query.docs.isEmpty) {
        return resultList;
      } else {
        for (QueryDocumentSnapshot doc in query.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Report rep = Report.fromMap(data);
          resultList.add(rep);

          print("------------DEBUG------------\n\n\n");
          print(rep.toString());
        }
        return resultList;
      }
    } catch (e) {
      Get.snackbar("Errore", e.toString());
    }

    return List.empty();
  }

  Future<List<Report>> findReportsByUserIdAndDate(
      String userId, DateTime dataVisita) async {
    try {
      List<Report> resultList = List.empty(growable: true);

      Timestamp inizioIntervallo = Timestamp.fromDate(dataVisita);
      Timestamp fineIntervallo =
          Timestamp.fromDate(dataVisita.add(Duration(days: 1)));

      QuerySnapshot query = await firestore
          .collection('Report')
          .where('uid_paziente', isEqualTo: userId)
          // .where('dataVisita', isGreaterThanOrEqualTo: inizioIntervallo)
          //.where('dataVisita', isLessThan: fineIntervallo)
          .get();

      if (query.docs.isEmpty) {
        return resultList;
      } else {
        for (QueryDocumentSnapshot doc in query.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Report rep = Report.fromMap(data);
          DateTime lastDate = dataVisita.add(Duration(days: 1));
          if (rep.dataVisita.isBefore(lastDate) &&
              rep.dataVisita.isAfter(dataVisita)) {
            //altrimenti crea indice e usa query con 2 campi
            resultList.add(rep);
          }
        }
        return resultList;
      }
    } catch (e) {
      Get.snackbar("Errore", e.toString());
    }

    return List.empty();
  }
}
