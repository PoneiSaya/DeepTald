import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_tald/model/entity/utente.dart';
import 'package:flutter/material.dart';

class userCard extends StatelessWidget{
  final String ruolo;
  final Utente utente;
  final VoidCallback onDelete;

  const userCard({required this.ruolo, required this.utente, required this.onDelete});

  @override
  Widget build (BuildContext context){
    String imagePath;
    if (ruolo == "dottore"){
       imagePath = "assets/images/doctor.png";
    }
    else {
      imagePath = "assets/images/patient.png";
    }
      
    return Card(
      child: ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage(imagePath)),
          title: Text(utente.getNome + " " +utente.getCognome),
          trailing:  IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              eliminaOggetto(utente.getId);
              onDelete();
            },
          )
      ),
    );
  }

  Future<void> eliminaOggetto(String idDocumento) async{
    String tabella;
    ruolo == "dottore"? tabella = "Medico" : tabella = "Pazienti";

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(tabella).doc(idDocumento);

    await documentReference.delete();
  }
}