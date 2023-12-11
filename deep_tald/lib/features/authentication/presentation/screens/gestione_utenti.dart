import 'package:deep_tald/features/authentication/controllers/admin_controller.dart';
import 'package:deep_tald/features/authentication/presentation/widget/user_card.dart';
import 'package:deep_tald/model/dto/utenteDto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GestioneUtentiPage extends StatefulWidget {
  const GestioneUtentiPage({super.key});

  @override
  State<GestioneUtentiPage> createState() => _GestioneUtentiPageState();
}

bool visualizzaMedici = false;

class _GestioneUtentiPageState extends State<GestioneUtentiPage> {
  AdminController adminController = Get.put(AdminController());
  TextEditingController ricercaController = TextEditingController();

  late UtenteDTO result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 250),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: //padding sopra e a sinistra
                EdgeInsets.only(
                    left: 30, top: MediaQuery.of(context).size.height / 9),
            child: Text(
              'Gestione Utenti',
              style: GoogleFonts.rubik(
                  color: const Color.fromARGB(255, 24, 24, 23),
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 22),
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              direction: Axis.horizontal,
              children: [
                Text(
                  "Pazienti",
                  style: GoogleFonts.rubik(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.height / 85,
                ),
                FlutterSwitch(
                  activeColor: const Color(0xFF599BFF),
                  inactiveColor: const Color.fromRGBO(191, 223, 225, 1),
                  value: visualizzaMedici,
                  onToggle: (value) {
                    setState(() {
                      visualizzaMedici = value;
                    });
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.height / 85,
                ),
                Text(
                  "Medici",
                  style: GoogleFonts.rubik(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 25),
          SingleChildScrollView(
              child: FutureBuilder(
                  future: adminController.getbyCodiceFiscale(
                      ricercaController.text,
                      visualizzaMedici ? "Medico" : "Pazienti"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      );
                    } else if (snapshot.hasError) {
                      return Text('Errore: ${snapshot.error}');
                    } else {
                      if (snapshot.hasData) {
                        result = snapshot.data as UtenteDTO;
                        return UserCard(
                          nome: result.getNome,
                          cognome: result.getCognome,
                          ruolo: result.getRuolo,
                          uid: result.getUid,
                        );
                      } else {
                        return Column(children: [
                          UserCard(
                              nome: "Michele",
                              cognome: "Mattiello",
                              ruolo: "ruolo",
                              uid: "uid"),
                          UserCard(
                              nome: "Michele",
                              cognome: "Mattiello",
                              ruolo: "ruolo",
                              uid: "uid"),
                          UserCard(
                              nome: "Michele",
                              cognome: "Mattiello",
                              ruolo: "ruolo",
                              uid: "uid"),
                          UserCard(
                              nome: "Michele",
                              cognome: "Mattiello",
                              ruolo: "ruolo",
                              uid: "uid"),
                          UserCard(
                              nome: "Michele",
                              cognome: "Mattiello",
                              ruolo: "ruolo",
                              uid: "uid"),
                        ]);
                      }
                    }
                  })),
          const Spacer(), //non e una soluzione ma e tardi
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              color: const Color.fromARGB(166, 203, 207, 209),
              border: Border.all(
                color: Colors.black, // Colore del bordo (nero)
                width: 1.0, // Larghezza del bordo in pixel
              ),
            ),
            child: TextField(
                controller: ricercaController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.clear), onPressed: _clearText),
                    labelText: visualizzaMedici
                        ? "Cerca Medico con Codice Fiscale"
                        : "Cerca Paziente con Codice Fiscale",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    border: InputBorder.none),
                onChanged: (value) => {
                      setState(() {
                        ;
                      })
                    }),
          )
        ],
      ),
    );
  }

  void _clearText() {
    ricercaController.clear();
  }
}
