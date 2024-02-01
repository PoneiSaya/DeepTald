import 'dart:io';

import 'package:deep_tald/model/entity/Item.dart';
import 'package:deep_tald/model/entity/logorrea.dart';
import 'package:deep_tald/model/entity/paziente.dart';
import 'package:deep_tald/model/entity/perseverance.dart';
import 'package:deep_tald/model/entity/ruminazione.dart';
import 'package:deep_tald/model/entity/slowedThinking.dart';

class Report {
  
  Logorrea logorreaObj;
  Perseverance perseveranceObj;
  Ruminazione ruminazioneObj;
  SlowedThinking slowedThinkingObj;
  DateTime dataVisita;
  String idPaziente;

  @override
  String toString() {
    return 'Report{'
        'logorreaObj: $logorreaObj, '
        'perseveranceObj: $perseveranceObj, '
        'ruminazioneObj: $ruminazioneObj, '
        'slowedThinkingObj: $slowedThinkingObj, '
        'idPaziente: $idPaziente,'
        'dataVisita: $dataVisita,'
        '}';
  }

  Report(
      {required Logorrea logorrea,
      required Perseverance perseverance,
      required Ruminazione ruminazione,
      required SlowedThinking slowedThinking,
      required DateTime data,
      required String id_paziente})
      : logorreaObj = logorrea,
        perseveranceObj = perseverance,
        ruminazioneObj = ruminazione,
        slowedThinkingObj = slowedThinking,
        dataVisita = data,
        idPaziente = id_paziente;

  factory Report.fromMap(Map<String, dynamic> data) {
    Logorrea logorrea = Logorrea(
      score: data['risultato_logorrea']['score_logorrea_report'] ?? '',
      questionCount: data['risultato_logorrea']['question_count'] ?? 0,
      nWordsDoctor: data['risultato_logorrea']['n_words_doctor'] ?? 0,
      nWordsPatient: data['risultato_logorrea']['n_words_patient'] ?? 0,
      interruptionCount: data['risultato_logorrea']['interruption_count'] ?? 0,
      avgResponseLength:
          data['risultato_logorrea']['avg_respons_length'] ?? 0.0,
      duration: data['risultato_logorrea']['duration'] ?? 0,
      speakingTimePatient:
          data['risultato_logorrea']['speaking_time_patient'] ?? 0,
      speakingTimeDoctor:
          data['risultato_logorrea']['speaking_time_doctor'] ?? 0,
    );
    print("sono nel from map");

    Perseverance perseverance = Perseverance(
        questionCounter: data['risultato_perseveranza']['counter_question'],
        counter: data['risultato_perseveranza']['counter'],
        score: data['risultato_perseveranza']['score_perseveranza'],
        resultString: data['risultato_perseveranza']['result_string']);

    Ruminazione ruminazione = Ruminazione(
        score: data['risultato_ruminazione']['score_ruminazione'],
        resultStringSentiment: data['risultato_ruminazione']
            ['result_string_sentiment'],
        resultStringTopic: data['risultato_ruminazione']['result_string_topic'],
        counterQuestions: data['risultato_ruminazione']['counter_question'],
        counter: data['risultato_ruminazione']['counter']);

    SlowedThinking slowedThinking = SlowedThinking(
        score: data['risultato_rallentato']['score_pensiero_rallentato'],
        questionCount: data['risultato_rallentato']['question_count'],
        nWordsDoctor: data['risultato_rallentato']['n_words_doctor'],
        nWordsPatient: data['risultato_rallentato']['n_words_patient'],
        pauseBetweenWords: data['risultato_rallentato']['pause_between_words'],
        responseTime: data['risultato_rallentato']['time_response']);

    return Report(
        logorrea: logorrea,
        perseverance: perseverance,
        ruminazione: ruminazione,
        slowedThinking: slowedThinking,
        data: (data['dataVisita'].toDate()),
        id_paziente: data['uid_paziente']);
  }

  toJson() {
    return {
      'dataVisita': dataVisita,
      'idPaziente': idPaziente,
      'Logorrea': {
        'score_logorrea_report': logorreaObj.getScore,
        'question_count': logorreaObj.questionCount,
        'n_words_doctor': logorreaObj.nWordsDoctor,
        'n_words_patient': logorreaObj.nWordsPatient,
        'interruption_count': logorreaObj.interruptionCount,
        'avg_respons_length': logorreaObj.avgResponseLength,
        'duration': logorreaObj.duration,
        'speaking_time_patient': logorreaObj.speakingTimePatient,
        'speaking_time_doctor': logorreaObj.speakingTimeDoctor,
      },
      'Perseveranza': {
        'counter_question': perseveranceObj.questionCounter,
        'counter': perseveranceObj.counter,
        'score_perseveranza': perseveranceObj.getScore,
        'result_string': perseveranceObj.resultString,
      },
      'Ruminazione': {
        'score_ruminazione': ruminazioneObj.getScore,
        'result_string_sentiment': ruminazioneObj.resultStringSentiment,
        'result_string_topic': ruminazioneObj.resultStringTopic,
        'counter_question': ruminazioneObj.counterQuestions,
        'counter': ruminazioneObj.counter,
      },
      'SlowedThinking': {
        'score_pensiero_rallentato': slowedThinkingObj.getScore,
        'question_count': slowedThinkingObj.questionCount,
        'n_words_doctor': slowedThinkingObj.nWordsDoctor,
        'n_words_patient': slowedThinkingObj.nWordsPatient,
        'pause_between_words': slowedThinkingObj.pauseBetweenWords,
        'time_response': slowedThinkingObj.responseTime,
      },
    };
  }
}
