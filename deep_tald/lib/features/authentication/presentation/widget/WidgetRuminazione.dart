import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../model/entity/ruminazione.dart';

class RuminazioneWidget extends StatelessWidget {
  final Ruminazione ruminazioneEntity;

  RuminazioneWidget(this.ruminazioneEntity, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String score = 'Score Finale: ${ruminazioneEntity.getScore}';
    String counter =
        'Numero di domande chieste dal bot: ${ruminazioneEntity.counter}';
    String topic = '${ruminazioneEntity.resultStringTopic}';
    String result =
        '\nString Sentiment: ${ruminazioneEntity.resultStringSentiment}';

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 250),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            //titolo in un rettangolo rounded colorato blue con il nome del report
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFF599BFF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Text(
                'Ruminazione',
                style: GoogleFonts.rubik(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                    fontSize: 24),
              ),
            ),
            Padding(
                padding: //padding sopra e a sinistra
                    EdgeInsets.only(
                        left: 30, top: MediaQuery.of(context).size.height / 35),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Score: ',
                    style: GoogleFonts.rubik(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400,
                        fontSize: 24),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF599BFF),
                    ),
                    child: Text(
                      ruminazioneEntity.getScore.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ])),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            //Text(perseveranzaEntity.counter.toString()),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(191, 223, 225, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    'Topic',
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    topic,
                    style: const TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            //sized box responsive
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(191, 223, 225, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  //testo con su scritto Risultati
                  const Text(
                    'Risultati',
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    result,
                    style: const TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: () async {
                final pdfPath = await _createPDF(score, counter, topic, result);
                if (pdfPath != null) {
                  print(pdfPath);
                  OpenFile.open(pdfPath);
                } else {
                  print("sassi");
                }
              },
              child: const Text(
                'Genera PDF',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<String> _createPDF(
    String score,
    String counter,
    String topic,
    String result,
  ) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(score),
              pw.Text(counter),
              pw.Text(topic),
              pw.Text(result),
            ],
          );
        },
      ),
    );
    final output = await getExternalStorageDirectory();
    final file = File("${output?.path}/example.pdf");
    await file.writeAsBytes(await pdf.save());
    return "${output?.path}/example.pdf";
  }
}
