// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

import './utente.dart';
import './medico.dart';
import './report.dart';

class Paziente extends Utente {
  late Medico _medico;
  late List<Report> _report;

  Paziente(String nome, String cognome, String codFiscale, String email,
      String password, DateTime dataDiNascita)
      : super(nome, cognome, codFiscale, email, password, dataDiNascita);

  get medico => _medico;
  set setMedico(Medico m) => _medico = m;

  get report => _report;
  set setReport(List<Report> rep) => _report = rep;

  factory Paziente.fromJson(Map<String, dynamic> data) {
    // Estrai i dati principali
    String id = data['id'];
    String nome = data['nome'];
    String cognome = data['cognome'];
    String codFiscale = data['codFiscale'];
    String email = data['email'];
    String password = data['password'];
    DateTime dataDiNascita = DateTime.parse(data['dataDiNascita']);

    // Crea un'istanza di Paziente
    Paziente paziente =
        Paziente(nome, cognome, codFiscale, email, password, dataDiNascita);
    return paziente;
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

  factory Paziente.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> dati = doc.data() as Map<String, dynamic>;
    Paziente paziente = Paziente(dati['Nome'], dati['Cognome'],
        dati['CodiceFiscale'], dati['Email'], dati['Password'], DateTime.now());
    paziente.setId(doc.id);
    return paziente;
  }
}
