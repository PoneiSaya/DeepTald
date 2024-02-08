import 'dart:io';
import 'dart:math';

import 'package:deep_tald/model/entity/perseverance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../model/entity/ruminazione.dart';

class WidgetPerseveranza extends StatelessWidget {
  final Perseverance perseveranzaEntity;

  WidgetPerseveranza(this.perseveranzaEntity, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),
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
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Text(
                'Perseveranza',
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
                        color: const Color.fromARGB(255, 24, 24, 23),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400,
                        fontSize: 24),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Text(
                      perseveranzaEntity.getScore.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ])),
            //sized box responsive
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
                    'Risultato',
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    perseveranzaEntity.resultString,
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
            SizedBox(height: MediaQuery.of(context).size.height / 20),

            //bottone per generare il pdf
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () async {
                  final pdfPath = await _createPDF(
                      perseveranzaEntity.getScore.toString(),
                      perseveranzaEntity.counter.toString(),
                      "Perseveranza",
                      perseveranzaEntity.resultString);

                  OpenFile.open(pdfPath);
                },
                child: const Text(
                  'Genera PDF',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                )),
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
