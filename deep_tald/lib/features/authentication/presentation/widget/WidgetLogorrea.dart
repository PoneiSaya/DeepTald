import 'dart:math';

import 'package:deep_tald/model/entity/slowedThinking.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../model/entity/logorrea.dart';

/*
  late int _questionCount;
  late int _nWordsDoctor;
  late int _nWordsPatient;
  late double _pauseBetweenWords;
  late double _responseTime;
*/

class LogorreaWidget extends StatelessWidget {
  late Logorrea ruminazioneEntity;

  LogorreaWidget(Logorrea ruminazione, {super.key}) {
    ruminazioneEntity = ruminazione;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 250),
      body: Column(
        children: [
          Padding(
            padding: //padding sopra e a sinistra
                EdgeInsets.only(
                    left: 30, top: MediaQuery.of(context).size.height / 20),
            child: Text(
              'Score Finale: ${ruminazioneEntity.getScore}',
              style: GoogleFonts.rubik(
                  color: const Color.fromARGB(255, 24, 24, 23),
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w400,
                  fontSize: 24),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 45),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(191, 223, 225, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Numero di domande chieste dal bot: ',
                          style: GoogleFonts.rubik(
                              color: const Color.fromARGB(255, 24, 24, 23),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        ),
                      ),
                      Text(
                        '${ruminazioneEntity.questionCount}',
                        style: GoogleFonts.rubik(
                            color: const Color.fromARGB(255, 24, 24, 23),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.2,
                    endIndent: 30,
                    indent: 30,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 200),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Durata: ',
                            style: GoogleFonts.rubik(
                                color: const Color.fromARGB(255, 24, 24, 23),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w300,
                                fontSize: 15),
                          )),
                      Text(
                        '${ruminazioneEntity.duration}',
                        style: GoogleFonts.rubik(
                            color: const Color.fromARGB(255, 24, 24, 23),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.2,
                    endIndent: 30,
                    indent: 30,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 200),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Numero interruzioni: ',
                            style: GoogleFonts.rubik(
                                color: const Color.fromARGB(255, 24, 24, 23),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w300,
                                fontSize: 15),
                          )),
                      Text(
                        '${ruminazioneEntity.interruptionCount}',
                        style: GoogleFonts.rubik(
                            color: const Color.fromARGB(255, 24, 24, 23),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.2,
                    endIndent: 30,
                    indent: 30,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 200),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.2,
                    endIndent: 30,
                    indent: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
