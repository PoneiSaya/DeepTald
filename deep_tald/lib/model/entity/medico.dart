// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

import './utente.dart';
import './paziente.dart';

class Medico extends Utente {
  late List<Paziente> _elencoPazienti;

  Medico(String nome, String cognome, String codFiscale, String email,
      String password, DateTime dataDiNascita)
      : super(nome, cognome, codFiscale, email, password, dataDiNascita);

  get getElencoPazienti => _elencoPazienti;
  set setElencoPazientu(lista) => _elencoPazienti = lista;

  void aggiungiPaziente(Paziente pz) {
    this._elencoPazienti.add(pz);
  }

  toJson(String? id) {
    return {
      'uid': id,
      "Nome": super.getNome,
      "Cognome": super.getCognome,
      "CodiceFiscale": super.getCodiceFiscale,
      "Email": super.getEmail,
      "Password": super.getPassword,
      "DataDiNascita": super.getDataDiNascita
    };
  }

  factory Medico.fromDocumentSnapshot(DocumentSnapshot doc){
    Map<String, dynamic> dati = doc.data() as Map<String, dynamic>;
    Medico medico = Medico(
      dati['Nome'],
      dati['Cognome'],
      dati['CodiceFiscale'],
      dati['Email'],
      dati['Password'],
      DateTime.now()
    );
    medico.setid(doc.id);
    return medico;
  }
}
