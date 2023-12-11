/// pattern DTO, stessa cosa di MODEL OBJECT
class UtenteDTO {
  String? nome, cognome, ruolo, uid, codFiscale;

  UtenteDTO(
      {required this.nome,
      required this.cognome,
      this.ruolo,
      required this.uid,
      required this.codFiscale});

  factory UtenteDTO.fromMap(Map<String, dynamic> map) {
    return UtenteDTO(
      nome: map['Nome'] as String?,
      cognome: map['Cognome'] as String?,
      uid: map['uid'] as String?,
      codFiscale: map['CodiceFiscale'] as String?,
      //il ruolo viene aggiunto nel controller
    );
  }

  get getNome => this.nome;
  get getCognome => cognome;
  get getRuolo => ruolo;
  get getUid => uid;
}
