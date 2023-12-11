import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_tald/features/authentication/presentation/widget/userCard.dart';
import 'package:deep_tald/model/entity/medico.dart';
import 'package:deep_tald/model/entity/paziente.dart';
import 'package:deep_tald/model/entity/utente.dart';
import 'package:flutter/material.dart';

/*
class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  AdminHomeScreenState createState() => AdminHomeScreenState();
}
class AdminHomeScreenState extends State<AdminHomeScreen> {
  TextEditingController _textController = TextEditingController();
  bool visualizzaMedici = true;
  late List<Utente> utentiVisualizzati;

  @override
  Widget build(BuildContext context) {
    String ruolo;
    if (visualizzaMedici) {
      ruolo = "dottore";
    } else {
      ruolo = "paziente";
    }
    return Container(
        color: Colors.white,
        margin: const EdgeInsets.only(
            top: 25.0, bottom: 10.0, left: 10.0, right: 10.0),
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Color.fromRGBO(244, 67, 54, 0.0)),
                child: ElevatedButton(
                  onPressed: () => {onClickButton()},
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(89, 155, 255,
                        1), // Trasparenza direttamente nel pulsante
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(visualizzaMedici
                      ? "Visualizza Pazienti"
                      : "Visualizza Medici"),
                )),
            Container(
              margin: EdgeInsets.only(top: 35.0, left: 10.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      visualizzaMedici
                          ? "Medici Presenti Nel Sistema"
                          : "Pazienti Presenti Nel Sistema",
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ),
            Container(
              margin:
                  const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
              height: MediaQuery.of(context).size.height * 0.6,
              child: FutureBuilder(
                future: leggiUtenti(_textController.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Errore: ${snapshot.error}');
                  } else {
                    utentiVisualizzati = snapshot.data ?? [];
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: utentiVisualizzati.length,
                        itemBuilder: (context, index) {
                          return userCard(
                              ruolo: ruolo,
                              utente: utentiVisualizzati[index],
                              onDelete: () {
                                setState(() {
                                  utentiVisualizzati.removeAt(index);
                                });
                              });
                        });
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 20.0, bottom: 10.0, left: 20.0, right: 20.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(234, 234, 234, 1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black, // Colore del bordo (nero)
                  width: 1.0, // Larghezza del bordo in pixel
                ),
              ),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: _clearText,
                    ),
                    labelText:
                        visualizzaMedici ? "Cerca Medico" : "Cerca Paziente",
                    labelStyle: TextStyle(
                      color: Colors
                          .black, // Colore desiderato per il testo del label
                    ),
                    border: InputBorder.none),
                onChanged: (value) => {
                  setState(() {
                    leggiUtenti(value);
                  })
                },
              ),
            )
          ],
        ));
  }

  onClickButton() {
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

    if (visualizzaMedici) {
      collection = FirebaseFirestore.instance.collection('Medico');
    } else {
      collection = FirebaseFirestore.instance.collection('Pazienti');
    }

    querySnapshot = await collection.get();
    List<Utente> utenti = querySnapshot.docs
        .map((doc) => Medico.fromDocumentSnapshot(doc))
        .toList();

    if (searchText.isNotEmpty) {
      return filtraUtenti(searchText, utenti);
    }

    return utenti;
  }

  List<Utente> filtraUtenti(String searchText, List<Utente> allUtenti) {
    return allUtenti
        .where((utente) =>
            utente.nome.toLowerCase().contains(searchText.toLowerCase()) ||
            utente.cognome.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }
}
*/