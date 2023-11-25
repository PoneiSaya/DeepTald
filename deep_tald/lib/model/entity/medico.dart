// ignore_for_file: file_names

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
}
