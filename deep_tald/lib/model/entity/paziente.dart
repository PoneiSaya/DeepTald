// ignore_for_file: file_names

import 'package:deep_tald/model/entity/utente.dart';
import 'package:deep_tald/model/entity/medico.dart';
import 'package:deep_tald/model/entity/report.dart';

class Paziente extends Utente {
  late Medico _medico;
  late List<Report> _report;

  Paziente(String id, String nome, String cognome, String codFiscale,
      String email, String password, DateTime dataDiNascita)
      : super(id, nome, cognome, codFiscale, email, password, dataDiNascita);

  get medico => _medico;
  set setMedico(Medico m) => _medico = m;

  get report => _report;
  set setReport(List<Report> rep) => _report = rep;
}
