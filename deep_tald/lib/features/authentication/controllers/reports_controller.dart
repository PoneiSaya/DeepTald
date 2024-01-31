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
      }
    } catch (e) {
      Get.snackbar("Errore", e.toString());
    }

    return List.empty();
  }
}
