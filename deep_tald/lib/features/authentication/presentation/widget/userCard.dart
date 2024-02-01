import 'package:deep_tald/features/authentication/controllers/admin_controller.dart';
import 'package:deep_tald/model/entity/utente.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserCard extends StatelessWidget {
  /*
  final String ruolo;
  final Utente utente;
  final VoidCallback onDelete;

  UserCard({required this.ruolo, required this.utente, required this.onDelete});*/

  //final AdminController adminController = Get.find();
  @override
  Widget build(BuildContext context) {
    String imagePath;
    //if (ruolo == "dottore") {
    imagePath = "assets/images/doctor.png";
    //} else {
    //imagePath = "assets/images/patient2.png";
    //}

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Card(
        shadowColor: Colors.black,
        color: const Color.fromRGBO(191, 223, 225, 1),
        child: ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage(imagePath)),
          title: const Text(
              /*utente.getNome +*/ "NOME COGNOME " /*+ utente.getCognome*/),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              //adminController.eliminaOggetto(utente.getId, ruolo);
              //onDelete();
            },
          ),
        ),
      ),
    );
  }
}
