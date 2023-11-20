// ignore_for_file: file_names

import 'package:deep_tald/model/entity/Paziente.dart';
import 'package:deep_tald/model/entity/Utente.dart';

class Medico extends Utente {
  late List<Paziente> _elencoPazienti;

  Medico(String id, String nome, String cognome, String codFiscale,
      String email, String password, DateTime dataDiNascita)
      : _elencoPazienti = [],
        super(id, nome, cognome, codFiscale, email, password, dataDiNascita);

  get getElencoPazienti => _elencoPazienti;
  set setElencoPazientu(lista) => _elencoPazienti = lista;

  void aggiungiPaziente(Paziente pz) {
    this._elencoPazienti.add(pz);
  }
}
