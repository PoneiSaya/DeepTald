import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class Utente {
  late String _id;
  late String nome;
  late String cognome;
  late String _codFiscale;
  late String _email;
  late String _password;
  late DateTime _dataDiNascita;

  Utente(this.nome, this.cognome, this._codFiscale, this._email, this._password,
      this._dataDiNascita);

  @protected
  void setId(String id) {
    _id = id;
  }

  @protected
  get getId {
    return _id;
  }

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

  @protected
  get getCodiceFiscale {
    return _codFiscale;
  }

  @protected
  get getDataDiNascita {
    return _dataDiNascita;
  }

  @protected
  get getPassword {
    return _password;
  }
}
