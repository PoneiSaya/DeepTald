import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_tald/model/entity/utente.dart';

class Admin extends Utente {
  Admin(String nome, String cognome, String codFiscale, String email,
      String password, DateTime dataDiNascita)
      : super(nome, cognome, codFiscale, email, password, dataDiNascita);

  factory Admin.fromJson(Map<String, dynamic> data) {
    // Estrai i dati principali
    String id = data['id'];
    String nome = data['nome'];
    String cognome = data['cognome'];
    String codFiscale = data['codFiscale'];
    String email = data['email'];
    String password = data['password'];
    DateTime dataDiNascita = DateTime.parse(data['dataDiNascita']);

    Admin admin =
        Admin(nome, cognome, codFiscale, email, password, dataDiNascita);
    return admin;
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

  factory Admin.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> dati = doc.data() as Map<String, dynamic>;
    Admin admin = Admin(dati['Nome'], dati['Cognome'], dati['CodiceFiscale'],
        dati['Email'], dati['Password'], DateTime.now());
    admin.setId(doc.id);
    return admin;
  }
}
