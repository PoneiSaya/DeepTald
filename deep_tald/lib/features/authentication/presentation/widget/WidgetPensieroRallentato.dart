import 'package:deep_tald/model/entity/slowedThinking.dart';
import 'package:flutter/material.dart';

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
    return Column(
      children: [
        const TextField(
          textAlign: TextAlign.center,
          readOnly: true,
        ),
        Text(pensieroRallentatoEntity.getScore.toString()),
        Text(pensieroRallentatoEntity.questionCount.toString()),
        Text(pensieroRallentatoEntity.nWordsPatient.toString()),
      ],
    );
  }
}
