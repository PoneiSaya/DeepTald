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
    this.pensieroRallentatoEntity = pensieroRallentato;
  }

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
              'Score Finale: ${pensieroRallentatoEntity.getScore}',
              style: GoogleFonts.rubik(
                  color: const Color.fromARGB(255, 24, 24, 23),
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w400,
                  fontSize: 24),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 25),
          AspectRatio(
            aspectRatio: 1.4,
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.blue,
                      value: (pensieroRallentatoEntity.questionCount as int)
                          .toDouble(),
                      title: 'Domande',
                      titleStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      radius: 150,
                    ),
                    PieChartSectionData(
                      color: const Color.fromRGBO(191, 223, 225, 1),
                      value: (pensieroRallentatoEntity.nWordsDoctor as int)
                          .toDouble(),
                      title: 'Parole Dottore',
                      titleStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      radius: 150,
                    ),
                    PieChartSectionData(
                      color: const Color.fromARGB(255, 18, 73, 118),
                      value: (pensieroRallentatoEntity.nWordsPatient as int)
                          .toDouble(),
                      title: 'Parole Paziente',
                      titleStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      radius: 150,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: Colors.blue,
                text: 'First',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.yellow,
                text: 'Second',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.red,
                text: 'Third',
                isSquare: true,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
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
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
