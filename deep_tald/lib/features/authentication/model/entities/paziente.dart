// ignore_for_file: file_names

import 'package:deep_tald/features/authentication/model/entities/utente.dart';
import 'package:deep_tald/model/entity/medico.dart';
import 'package:deep_tald/model/entity/report.dart';

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

  toJson() {
    return {
      "Nome": super.getNome,
      "Cognome": super.getCognome,
      "CodiceFiscale": super.getCodiceFiscale,
      "Email": super.getEmail,
      "Password": super.getPassword,
      "DataDiNascita": super.getDataDiNascita
    };
  }
}
