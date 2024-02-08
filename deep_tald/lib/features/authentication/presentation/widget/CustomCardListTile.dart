import 'package:deep_tald/features/authentication/presentation/widget/TALDinfo/LogorreaInfo.dart';
import 'package:deep_tald/features/authentication/presentation/widget/TALDinfo/PensieroRallentatoInfo.dart';
import 'package:deep_tald/features/authentication/presentation/widget/TALDinfo/PerseveranzaInfo.dart';
import 'package:deep_tald/features/authentication/presentation/widget/TALDinfo/RuminazioneInfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCardListTile extends StatelessWidget {
  late String _testo;
  late int _score;
  late Widget reportAssociato;

  CustomCardListTile(String testo, int score, Widget widget, {super.key}) {
    _testo = testo;
    _score = score;
    reportAssociato = widget;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xfff5f6fa),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
              style: const TextStyle(fontSize: 16),
            ),

            // Parte destra della card
            Row(
              children: [
                // Cerchio colorato con numero
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF599BFF),
                  ),
                  child: Text(
                    _score.toString(),
                    style: const TextStyle(
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
                      backgroundColor: const Color(0xfff5f6fa),
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration:
                                const BoxDecoration(color: Color(0xfff5f6fa)),
                            child: reportAssociato,
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
                          contentPadding: const EdgeInsets.all(
                              0), // Rimuovi i padding predefiniti
                          content: Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: (() {
                              switch (_testo) {
                                case "Perseveranza":
                                  return const PerseveranzaInfo();
                                case "Ruminazione":
                                  return const RuminazioneInfo();
                                case "Pensiero\nRallentato":
                                  return const PensieroRallentatoInfo();
                                case "Logorrea":
                                  return const LoggoreaInfo();
                                default:
                                  return null;
                              }
                            })(),
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.info),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
