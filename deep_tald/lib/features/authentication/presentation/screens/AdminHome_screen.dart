import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_tald/features/authentication/presentation/widget/userCard.dart';
import 'package:deep_tald/model/entity/medico.dart';
import 'package:deep_tald/model/entity/paziente.dart';
import 'package:deep_tald/model/entity/utente.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget{
  const AdminHomeScreen({super.key});

  @override
  AdminHomeScreenState createState() => AdminHomeScreenState();
}

class AdminHomeScreenState extends State<AdminHomeScreen>{
  bool visualizzaMedici = true;

  @override
  Widget build(BuildContext context) {
    String ruolo;
    if (visualizzaMedici){
      ruolo = "dottore";
    }
    else{
      ruolo = "paziente";
    }
    return Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 30.0, bottom: 10.0, left: 10.0, right: 10.0),
        child: Column(
          children: [
            const SearchBar(),
            ElevatedButton(onPressed: () => {
              onClickButton()
            }, child: Text(visualizzaMedici? "Visualizza Pazienti" : "Visualizza Medici")),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Medici presenti nel sistema", 
              style: TextStyle(
                fontWeight: FontWeight.bold
              ))
              ),
            FutureBuilder(
              future: leggiUtenti(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Errore: ${snapshot.error}');
                } else{
                  List<Utente> utenti = snapshot.data ?? [];
                  return Expanded( 
                    child: ListView.builder(
                    itemCount: utenti.length,
                    itemBuilder: (context, index) {
                    return userCard(ruolo: ruolo, nome: utenti[index].nome, cognome: utenti[index].cognome);
                    },
                  ));
                }
              },
            ),
          ],
        )
    );
  }

  onClickButton(){
    setState(() {
      visualizzaMedici = !visualizzaMedici;
    });
  }

  Future<List<Utente>> leggiUtenti() async {
    CollectionReference collection;
    if(visualizzaMedici){
      collection = FirebaseFirestore.instance.collection('Medico');
    }
    else{
      collection = FirebaseFirestore.instance.collection('Pazienti');
    }
    QuerySnapshot querySnapshot = await collection.get();
    
    List<Utente> medici =
        querySnapshot.docs.map((doc) => Paziente.fromDocumentSnapshot(doc)).toList();
    return medici;
  }
}