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
      imagePath = "assets/images/patient2.png";
    }
      
    return Container(
      margin: EdgeInsets.only(left: 8.0, right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Card(
        shadowColor: Colors.black,
        color: Color.fromRGBO(191,223,225, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(0.2),
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
      )
      )
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