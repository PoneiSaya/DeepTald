import 'package:deep_tald/features/authentication/controllers/admin_controller.dart';
import 'package:deep_tald/features/authentication/controllers/auth_controller.dart';
import 'package:deep_tald/features/authentication/controllers/medico_controller.dart';
import 'package:deep_tald/features/authentication/controllers/reports_controller.dart';
import 'package:deep_tald/features/authentication/presentation/widget/userCardMonitora.dart';
import 'package:deep_tald/features/authentication/presentation/widget/user_card.dart';
import 'package:deep_tald/model/dto/utenteDto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MonitoraPazientiPage extends StatefulWidget {
  const MonitoraPazientiPage({super.key});

  @override
  State<MonitoraPazientiPage> createState() => _MonitoraPazientiPageState();
}

class _MonitoraPazientiPageState extends State<MonitoraPazientiPage> {
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
              'Monitora i tuoi pazienti!',
              style: GoogleFonts.rubik(
                  color: const Color.fromARGB(255, 24, 24, 23),
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height / 25),
          //bottone

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
                    labelText: "Cerca Paziente con Codice Fiscale",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    border: InputBorder.none),
                onChanged: (value) => {setState(() {})}),
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
                    return UserCardMonitora(
                      nome: elencoPazienti[index].getNome,
                      cognome: elencoPazienti[index].getCognome,
                      ruolo: elencoPazienti[index].getRuolo,
                      uid: elencoPazienti[index].getUid,
                    );
                  });
            } else {
              return const Text("Non ci sono pazienti associati");
            }
          }
        });
  }
}
