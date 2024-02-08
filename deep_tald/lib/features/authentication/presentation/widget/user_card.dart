import 'package:deep_tald/features/authentication/controllers/admin_controller.dart';
import 'package:deep_tald/features/medico_ia/presentation/screens/usa_ia_page.dart';
import 'package:deep_tald/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UserCard extends StatefulWidget {
  late String nome, cognome;
  late String ruolo;
  late String uid;
  late bool analizza;

  UserCard(
      {super.key,
      required this.nome,
      required this.cognome,
      required this.ruolo,
      required this.uid,
      required this.analizza});

  @override
  UserCardState createState() => UserCardState();
}

class UserCardState extends State<UserCard> {
  AdminController adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: Card(
        color: const Color.fromRGBO(191, 223, 225, 1),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Image.asset(
                      "assets/images/patient2.png",
                      width: 30,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "${widget.nome} ${widget.cognome}",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.rubik(
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                  ),
                ),
                const Spacer(),
                //se analizza e true allora mostro il bottone
                if (widget.analizza)
                  IconButton(
                    iconSize: 35,
                    padding:
                        const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                    icon: const Icon(Icons.analytics),
                    onPressed: () {
                      //passagli  l'uid e il nome
                      Get.toNamed(Routes.getMedicoIa(),
                          arguments: [widget.uid, widget.nome]);
                    },
                  )
                else
                  IconButton(
                    iconSize: 35,
                    padding:
                        const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      adminController.eliminaOggetto(widget.uid, widget.ruolo);
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
