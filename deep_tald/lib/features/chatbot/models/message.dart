enum Mittente { CHATBOT, UTENTE }

class Message {
  int? id;
  String? text;
  DateTime? dataCreazione;
  Mittente? mittente;

  // Costruttore vuoto
  Message();

  // Costruttore con tutti i campi
  Message.full(this.id, this.text, this.dataCreazione, this.mittente);

  // Factory constructor
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message.full(
      json['id'] as int?,
      json['text'] as String?,
      DateTime.parse(json['dataCreazione'] as String? ?? ''),
      Mittente.values.firstWhere(
        (e) =>
            e.toString() == 'Mittente.' + (json['mittente'] as String? ?? ''),
        orElse: () => Mittente.CHATBOT,
      ),
    );
  }

  get getMittente => this.mittente;

  set setMittente(mittente) => this.mittente = mittente;

  get getId => this.id;

  set setId(id) => this.id = id;

  get getText => this.text;

  set setText(text) => this.text = text;

  get getDataCreazione => this.dataCreazione;

  set setDataCreazione(dataCreazione) => this.dataCreazione = dataCreazione;
}
