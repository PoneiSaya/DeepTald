import 'package:flutter/foundation.dart';

abstract class Utente {
  late String _id;
  late String nome;
  late String cognome;
  late String _codFiscale;
  late String _email;
  late String _password;
  late DateTime _dataDiNascita;

  Utente(this._id, this.cognome, this.nome, this._codFiscale, this._email,
      this._password, this._dataDiNascita);

  @protected
  get getNome {
    return nome;
  }

  @protected
  get getCognome {
    return cognome;
  }

  @protected
  get getEmail {
    return _email;
  }
}
