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
  TextEditingController _textController = TextEditingController();
  bool visualizzaMedici = true;
  late List<Utente> utentiVisualizzati; 

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
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(icon: Icon(Icons.clear), onPressed: _clearText,),
                labelText: visualizzaMedici? "Cerca Medico" : "Cerca Paziente",
                border: OutlineInputBorder()
                ),
              onChanged: (value) => {
                setState(() {
                  leggiUtenti(value);
                })
              },
            ),
            ElevatedButton(onPressed: () => {
              onClickButton()
            }, child: Text(visualizzaMedici? "Visualizza Pazienti" : "Visualizza Medici")),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(visualizzaMedici? "Medici Presenti Nel Sistema" : "Pazienti Presenti Nel Sistema", 
              style: TextStyle(
                fontWeight: FontWeight.bold
              ))
              ),
            FutureBuilder(
              future: leggiUtenti(_textController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Errore: ${snapshot.error}');
                } else{
                    utentiVisualizzati = snapshot.data ?? [];
                    return Expanded( 
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: utentiVisualizzati.length,
                        itemBuilder: (context, index) {
                          return userCard(ruolo: ruolo, nome: utentiVisualizzati[index].nome, cognome: utentiVisualizzati[index].cognome);
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

  void _clearText() {
    _textController.clear();
  }

  Future<List<Utente>> leggiUtenti(String searchText) async {
    CollectionReference collection;
    QuerySnapshot querySnapshot;

    if(visualizzaMedici){
      collection = FirebaseFirestore.instance.collection('Medico');
    }
    else{
      collection = FirebaseFirestore.instance.collection('Pazienti');
    }

    if(searchText.isEmpty){
      querySnapshot = await collection.get();
    }else{
      querySnapshot = await collection
      .where('Nome', isGreaterThanOrEqualTo: searchText)
      .where('Nome', isLessThanOrEqualTo: searchText + '\uf8ff')
      .get();
    }
    List<Utente> utenti =
        querySnapshot.docs.map((doc) => Paziente.fromDocumentSnapshot(doc)).toList();

    return utenti;
  }
}