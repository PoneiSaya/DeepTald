import 'dart:math';

import 'package:deep_tald/model/entity/slowedThinking.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

/*
  late int _questionCount;
  late int _nWordsDoctor;
  late int _nWordsPatient;
  late double _pauseBetweenWords;
  late double _responseTime;
*/

class PensieroRallentatoWidget extends StatelessWidget {
  late SlowedThinking pensieroRallentatoEntity;

  PensieroRallentatoWidget(SlowedThinking pensieroRallentato, {super.key}) {
    pensieroRallentatoEntity = pensieroRallentato;
  }

  @override
  Widget build(BuildContext context) {
    String pensieroRallentatoScore = pensieroRallentatoEntity.getScore < 0
        ? "0"
        : pensieroRallentatoEntity.getScore.toString();
    return Scaffold(
        backgroundColor: const Color(0xfff5f6fa),
        body: SingleChildScrollView(
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
                  'Pensiero Rallentato',
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
                            color: Color(0xFF599BFF),
                          ),
                          child: Text(
                            pensieroRallentatoScore,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ])),
              SizedBox(height: MediaQuery.of(context).size.height / 50),
              AspectRatio(
                aspectRatio: 1.2,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        
                        PieChartSectionData(
                          color: const Color.fromARGB(255, 53, 139, 145),
                          value: (pensieroRallentatoEntity.nWordsDoctor as int)
                              .toDouble(),
                          titleStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          radius: 150,
                        ),
                        PieChartSectionData(
                          color: const Color.fromARGB(255, 18, 73, 118),
                          value: (pensieroRallentatoEntity.nWordsPatient as int)
                              .toDouble(),
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
                    color: Color.fromRGBO(191, 223, 225, 1),
                    text: 'Parole Dottore',
                    isSquare: false,
                  ),
                  Indicator(
                    color: Color.fromARGB(255, 18, 73, 118),
                    text: 'Parole Paziente',
                    isSquare: false,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 25),
              Container(
                height: MediaQuery.of(context).size.height / 3.3,
                width: MediaQuery.of(context).size.width / 1.00,
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
                            '${pensieroRallentatoEntity.questionCount}',
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
                                'Numero parole dottore: ',
                                style: GoogleFonts.rubik(
                                    color:
                                        const Color.fromARGB(255, 24, 24, 23),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              )),
                          Text(
                            '${pensieroRallentatoEntity.nWordsDoctor}',
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
                                'Numero parole paziente: ',
                                style: GoogleFonts.rubik(
                                    color:
                                        const Color.fromARGB(255, 24, 24, 23),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              )),
                          Text(
                            '${pensieroRallentatoEntity.nWordsPatient}',
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
                                'Pausa tra parole (Average): ',
                                style: GoogleFonts.rubik(
                                    color:
                                        const Color.fromARGB(255, 24, 24, 23),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              )),
                          Text(
                            '${pensieroRallentatoEntity.pauseBetweenWords}',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                'Response Time (Average): ',
                                style: GoogleFonts.rubik(
                                    color:
                                        const Color.fromARGB(255, 24, 24, 23),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              )),
                          Text(
                            '${pensieroRallentatoEntity.responseTime}',
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

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 12,
        ),
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
