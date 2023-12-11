import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_tald/features/authentication/presentation/widget/user_card.dart';
import 'package:deep_tald/model/dto/utenteDto.dart';
import 'package:deep_tald/repository/user_repository.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserRepository userRepository = Get.find();
  List<UtenteDTO> elencoCards = List.empty(growable: true);

  Future<List<UtenteDTO>> getElencoCards() async {
    return await this.elencoCards;
  }

  Future<void> eliminaOggetto(String idDocumento, String ruolo) async {
    print("sono in elimina");
    String tabella;
    ruolo == "dottore" ? tabella = "Medico" : tabella = "Pazienti";

    DocumentReference documentReference =
        firestore.collection(tabella).doc(idDocumento);

    await documentReference.delete();
  }

  /// Metodo in cui si cercano utenti nel db
  /// [codiceFiscale] è il codice fiscale inserito
  /// [tabella] puo avere due valori: Medico o Pazienti e indica in che tabella occorre andare a cercare
  ///
  Future<UtenteDTO?> getbyCodiceFiscale(
      String codiceFiscale, String tabella) async {
    if (codiceFiscale.isEmpty || codiceFiscale.length != 16) {
      return null;
    }
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection(tabella)
          .where('CodiceFiscale', isEqualTo: codiceFiscale)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic>? data =
            querySnapshot.docs.first.data() as Map<String, dynamic>;

        late String ruolo;
        tabella == "Medico" ? ruolo = "medico" : ruolo = "paziente";

        UtenteDTO result = UtenteDTO.fromMap(data);
        result.ruolo = ruolo;

        return result;
      } else {
        print('non ho trovato niente');
        Get.snackbar(
            "Errore", "Nessun utente trovato con questo codice fiscale.");
        return null;
      }
    } catch (e) {
      Get.snackbar("Errore", "Errore del server nella ricerca.");
    }
  }
}
