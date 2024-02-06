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
    String topic = 'Topic: ${ruminazioneEntity.resultStringTopic}';
    String result =
        'Result \nString Sentiment: ${ruminazioneEntity.resultStringSentiment}';

    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(score),
            Text(counter),
            Text(topic),
            Text(result),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final pdfPath = await _createPDF(score, counter, topic, result);
                if (pdfPath != null) {
                  print(pdfPath);
                  OpenFile.open(pdfPath);
                } else {
                  print("sassi");
                }
              },
              child: Text('Genera PDF'),
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
