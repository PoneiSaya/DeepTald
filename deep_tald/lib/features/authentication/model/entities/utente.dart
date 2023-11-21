abstract class Utente {
  late String _id;
  late String _nome;
  late String _cognome;
  late String _codFiscale;
  late String _email;
  late String _password;
  late DateTime _dataDiNascita;

  Utente(this._id, this._cognome, this._nome, this._codFiscale, this._email,
      this._password, this._dataDiNascita);
}
