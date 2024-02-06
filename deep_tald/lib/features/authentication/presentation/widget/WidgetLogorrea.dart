import 'dart:math';

import 'package:deep_tald/features/authentication/presentation/widget/WidgetPensieroRallentato.dart';
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
  late Logorrea logorreaEntity;

  LogorreaWidget(Logorrea ruminazione, {super.key}) {
    logorreaEntity = ruminazione;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 246, 250),
        body: SingleChildScrollView(
          child: Column(
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
                  'Logorrea',
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
                          left: 30,
                          top: MediaQuery.of(context).size.height / 35),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                            logorreaEntity.getScore.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ])),
              SizedBox(height: MediaQuery.of(context).size.height / 25),
              AspectRatio(
                aspectRatio: 1.2,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          color: Colors.blue,
                          value:
                              logorreaEntity.speakingTimeDoctor.roundToDouble(),
                          titleStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          radius: 150,
                        ),
                        PieChartSectionData(
                          color: const Color.fromARGB(255, 53, 139, 145),
                          //round value to 2 decimal places

                          value: logorreaEntity.speakingTimePatient
                              .roundToDouble(),
                          titleStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          radius: 150,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Indicator(
                    color: Colors.blue,
                    text: 'Durata secondi Dottore',
                    isSquare: false,
                  ),
                  Indicator(
                    color: Color.fromARGB(255, 53, 139, 145),
                    text: 'Durata secondi Paziente',
                    isSquare: false,
                  ),
                ],
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
                      const Divider(
                        color: Colors.black,
                        thickness: 0.2,
                        endIndent: 30,
                        indent: 30,
                      ),
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
                            '${logorreaEntity.questionCount}',
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
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 200),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                'Durata Totale: ',
                                style: GoogleFonts.rubik(
                                    color:
                                        const Color.fromARGB(255, 24, 24, 23),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              )),
                          Text(
                            '${logorreaEntity.duration.round()} secondi',
                            style: GoogleFonts.rubik(
                                color: const Color.fromARGB(255, 24, 24, 23),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                          //avg response length
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 0.2,
                        endIndent: 30,
                        indent: 30,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 200),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                'Numero interruzioni: ',
                                style: GoogleFonts.rubik(
                                    color:
                                        const Color.fromARGB(255, 24, 24, 23),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              )),
                          Text(
                            '${logorreaEntity.interruptionCount}',
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
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 200),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                'Numero di parole del dottore: ',
                                style: GoogleFonts.rubik(
                                    color:
                                        const Color.fromARGB(255, 24, 24, 23),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              )),
                          Text(
                            '${logorreaEntity.nWordsDoctor}',
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
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 200),
                      //numero di parole del paziente
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                'Numero di parole del paziente: ',
                                style: GoogleFonts.rubik(
                                    color:
                                        const Color.fromARGB(255, 24, 24, 23),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              )),
                          Text(
                            '${logorreaEntity.nWordsPatient}',
                            style: GoogleFonts.rubik(
                                color: const Color.fromARGB(255, 24, 24, 23),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      //avg response length
                      const Divider(
                        color: Colors.black,
                        thickness: 0.2,
                        endIndent: 30,
                        indent: 30,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 200),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                'Pausa media tra le parole: ',
                                style: GoogleFonts.rubik(
                                    color:
                                        const Color.fromARGB(255, 24, 24, 23),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              )),
                          Text(
                            '${logorreaEntity.avgResponseLength.toStringAsFixed(2)} secondi',
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
