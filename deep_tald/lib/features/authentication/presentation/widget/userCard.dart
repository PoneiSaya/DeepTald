import 'package:flutter/material.dart';

class userCard extends StatelessWidget{
  final String ruolo;
  final String nome;
  final String cognome;

  const userCard({required this.ruolo, required this.nome, required this.cognome});

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
          title: Text("$nome $cognome"),
          trailing:  ElevatedButton(
            onPressed: () {},
            child: const Text("Info")
          )
      ),
    );
  }
}