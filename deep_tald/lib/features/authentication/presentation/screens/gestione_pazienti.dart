import 'package:deep_tald/features/authentication/controllers/admin_controller.dart';
import 'package:deep_tald/features/authentication/controllers/auth_controller.dart';
import 'package:deep_tald/features/authentication/controllers/medico_controller.dart';
import 'package:deep_tald/features/authentication/presentation/widget/user_card.dart';
import 'package:deep_tald/model/dto/utenteDto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GestionePazientiPage extends StatefulWidget {
  const GestionePazientiPage({super.key});

  @override
  State<GestionePazientiPage> createState() => _GestionePazientiPageState();
}

class _GestionePazientiPageState extends State<GestionePazientiPage> {
  String testoInserito = "";
  AuthController authController = Get.find();
  AdminController adminController = Get.put(AdminController());
  TextEditingController ricercaController = TextEditingController();
  MedicoController medicoController = Get.put(MedicoController());

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
              'Gestione Pazienti',
              style: GoogleFonts.rubik(
                  color: const Color.fromARGB(255, 24, 24, 23),
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height / 25),
          //bottone
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 15,
              child: ElevatedButton(
                onPressed: () {
                  //apri una modale
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Aggiungi Paziente'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                const Text(
                                    'Inserisci l\'email del paziente che vuoi aggiungere!'),
                                //widget per inserire il testo
                                TextField(
                                  onChanged: (value) => {
                                    testoInserito = value,
                                  },
                                  //variabile che contiene il testo inserito
                                  //controller: emailController,

                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'E-mail'),
                                )
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Annulla'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Aggiungi'),
                              onPressed: () async {
                                String idMedico =
                                    await medicoController.getIdMedico(
                                        // ignore: invalid_use_of_protected_member
                                        authController.utente!.getEmail);
                                String idPaziente = await medicoController
                                    .getIdPaziente(testoInserito);

                                if (idPaziente != "") {
                                  //associa paziente a medico
                                  medicoController.associaPaziente(
                                      idMedico, idPaziente);
                                  // ignore: use_build_context_synchronously
                                }

                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0)),
                    backgroundColor: Colors.black),
                child: const Text(
                  'Aggiungi Paziente',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
              child: FutureBuilder(
                  future: buildListPazienti(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Errore: ${snapshot.error}');
                    } else {
                      if (snapshot.hasData) {
                        return snapshot.data as Widget;
                      } else {
                        return const Text("Non ci sono pazienti associati");
                      }
                    }
                  })),
          const Spacer(), //non e una soluzione ma e tardi
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              color: Color.fromARGB(166, 222, 227, 229),
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
                    labelText: "Cerca Paziente con Codice Fiscale",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    border: InputBorder.none),
                onChanged: (value) => {setState(() {})}),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  void _clearText() {
    ricercaController.clear();
  }

  //metodo che builda la lista di pazienti usando il metodo getPazientiAssociati
  Future<Widget> buildListPazienti() async {
    return FutureBuilder(
        future: medicoController.getPazientiAssociati(await medicoController
            // ignore: invalid_use_of_protected_member
            .getIdMedico(authController.utente!.getEmail)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              backgroundColor: Colors.black,
            );
          } else if (snapshot.hasError) {
            return Text('Errore: ${snapshot.error}');
          } else {
            if (snapshot.hasData) {
              List<UtenteDTO> elencoPazienti = snapshot.data as List<UtenteDTO>;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: elencoPazienti.length,
                  itemBuilder: (context, index) {
                    return UserCard(
                      nome: elencoPazienti[index].getNome,
                      cognome: elencoPazienti[index].getCognome,
                      ruolo: elencoPazienti[index].getRuolo,
                      uid: elencoPazienti[index].getUid,
                      analizza: false,
                    );
                  });
            } else {
              return const Text("Non ci sono pazienti associati");
            }
          }
        });
  }
}
