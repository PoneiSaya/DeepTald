import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCardListTile extends StatelessWidget {
  late String _testo;
  CustomCardListTile(String testo, {super.key}) {
    _testo = testo;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Testo sulla sinistra
            Text(
              this._testo,
              style: TextStyle(fontSize: 16),
            ),

            // Parte destra della card
            Row(
              children: [
                // Cerchio colorato con numero
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Text(
                    '42',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Bottone
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF599BFF),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // Apri una modal al centro dello schermo
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(children: [
                              CustomCardListTile("Perseveranza"),
                              CustomCardListTile("Perseveranza"),
                              CustomCardListTile("Perseveranza"),
                              CustomCardListTile("Perseveranza"),
                              CustomCardListTile("Perseveranza"),
                              CustomCardListTile("Perseveranza"),
                              CustomCardListTile("Perseveranza"),
                              CustomCardListTile("Perseveranza"),
                              CustomCardListTile("Perseveranza"),
                            ]),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    "Report",
                    style: GoogleFonts.rubik(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),

                const SizedBox(width: 16),

                // Icona di informazioni cliccabile
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Informazioni'),
                          content:
                              Text('Qua ci vanno le informazioni del report'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Chiudi'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Icon(Icons.info),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
