import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_tald/features/authentication/presentation/widget/user_card.dart';
import 'package:deep_tald/model/dto/utenteDto.dart';
import 'package:deep_tald/repository/user_repository.dart';
import 'package:get/get.dart';

class MedicoController extends GetxController {
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

  Future<UtenteDTO?> getPazientebyEmail(String email) async {
    if (email.isEmpty) {
      return null;
    }
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection("Pazienti")
          .where('Email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic>? data =
            querySnapshot.docs.first.data() as Map<String, dynamic>;

        late String ruolo;
        ruolo = "paziente";

        UtenteDTO result = UtenteDTO.fromMap(data);
        result.ruolo = ruolo;
        //Get.snackbar('TROVATO', 'Paziente trovato');
        return result;
      } else {
        print('non ho trovato niente');
        Get.snackbar("Errore", "Nessun utente trovato con questa email.");
        return null;
      }
    } catch (e) {
      Get.snackbar("Errore", "Errore del server nella ricerca.");
    }
  }

  //get id medico
  Future<String> getIdMedico(String email) async {
    String idMedico = "";
    try {
      print("ccomi");
      QuerySnapshot querySnapshot = await firestore
          .collection("Medico")
          .where('Email', isEqualTo: email)
          .get();
      print(querySnapshot.docs);
      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic>? data =
            querySnapshot.docs.first.data() as Map<String, dynamic>;

        idMedico = data['uid'];
        String prova = querySnapshot.docs.first.id;
        //Get.snackbar("idTrovato", "idMedico: $prova;");

        return prova;
      } else {
        print('non ho trovato niente');
        Get.snackbar("Errore", "Nessun utente trovato con questa email.");
        return idMedico;
      }
    } catch (e) {
      Get.snackbar("Errore", "Errore del server nella ricerca.");
    }
    return idMedico;
  }

  Future<String> getIdPaziente(String email) async {
    String idMedico = "";
    try {
      print("ccomi");
      QuerySnapshot querySnapshot = await firestore
          .collection("Pazienti")
          .where('Email', isEqualTo: email)
          .get();
      print(querySnapshot.docs);
      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic>? data =
            querySnapshot.docs.first.data() as Map<String, dynamic>;

        idMedico = data['uid'];
        String prova = querySnapshot.docs.first.id;
        //Get.snackbar("idTrovato", "idPaziente: $prova;");

        return prova;
      } else {
        print('non ho trovato niente');
        Get.snackbar("Errore", "Nessun utente trovato con questa email.");
        return idMedico;
      }
    } catch (e) {
      Get.snackbar("Errore", "Errore del server nella ricerca.");
    }
    return idMedico;
  }

  //associa paziente a medico
  Future<void> associaPaziente(String idMedico, String idPaziente) async {
    print("sono in associa");
    DocumentReference documentReference =
        firestore.collection("Medico").doc(idMedico);

    //se non hai trovato il medico
    print("trovato medico con id $idMedico");
    //stampa il doc reference
    print(documentReference.id);
    //se Pazienti non esiste lo crea
    await documentReference.set({
      'Pazienti': FieldValue.arrayUnion([idPaziente])
    }, SetOptions(merge: true));
  }

  //recupera pazienti associati al medico
  Future<List<UtenteDTO>> getPazientiAssociati(String idMedico) async {
    List<UtenteDTO> elencoPazienti = List.empty(growable: true);
    try {
      DocumentSnapshot documentSnapshot =
          await firestore.collection("Medico").doc(idMedico).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>;

        List<dynamic> pazienti = data!['Pazienti'];

        for (var i = 0; i < pazienti.length; i++) {
          DocumentSnapshot documentSnapshotPaziente =
              await firestore.collection("Pazienti").doc(pazienti[i]).get();

          if (documentSnapshotPaziente.exists) {
            Map<String, dynamic>? dataPaziente =
                documentSnapshotPaziente.data() as Map<String, dynamic>;

            UtenteDTO result = UtenteDTO.fromMap(dataPaziente);
            result.ruolo = "paziente";
            elencoPazienti.add(result);
          }
        }
        return elencoPazienti;
      } else {
        print('non ho trovato niente');
        Get.snackbar("Errore", "Nessun utente trovato con questa email.");
        return elencoPazienti;
      }
    } catch (e) {
      Get.snackbar("Errore", "Errore del server nella ricerca.");
    }
    return elencoPazienti;
  }
}
