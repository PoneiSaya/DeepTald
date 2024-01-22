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
  int idPaziente;

  Report({
    required Logorrea logorrea,
    required Perseverance perseverance,
    required Ruminazione ruminazione,
    required SlowedThinking slowedThinking,
    required DateTime data,
    required int id_paziente
  }): logorreaObj = logorrea,
      perseveranceObj = perseverance,
      ruminazioneObj = ruminazione,
      slowedThinkingObj = slowedThinking,
      dataVisita = data,
      idPaziente = id_paziente;


     
    factory Report.fromMap(Map<String, dynamic> data) {
    Logorrea logorrea = Logorrea(
      score: data['Logorrea']['score_logorrea_report'] ?? '',
      questionCount: data['Logorrea']['question_count'] ?? 0,
      nWordsDoctor: data['Logorrea']['n_words_doctor'] ?? 0,
      nWordsPatient: data['Logorrea']['n_words_patient'] ?? 0,
      interruptionCount: data['Logorrea']['interruption_count'] ?? 0,
      avgResponseLength: data['Logorrea']['avg_respons_length'] ?? 0.0,
      duration: data['Logorrea']['duration'] ?? 0,
      speakingTimePatient: data['Logorrea']['speaking_time_patient'] ?? 0,
      speakingTimeDoctor: data['Logorrea']['speaking_time_doctor'] ?? 0,
    );

    Perseverance perseverance = Perseverance(
      questionCounter: data['Perseveranza']['counter_question'], 
      counter: data['Perseveranza']['counter'], 
      score: data['Perseveranza']['score_perseveranza'],
      resultString: data['Perseveranza']['result_string']
      );

    Ruminazione ruminazione = Ruminazione(
      score: data['Ruminazione']['score_ruminazione'], 
      resultStringSentiment: data['Ruminazione']['result_string_sentiment'], 
      resultStringTopic: data['Ruminazione']['result_string_topic'], 
      counterQuestions: data['Ruminazione']['counter_question'], 
      counter: data['Ruminazione']['counter']
      );

      SlowedThinking slowedThinking = SlowedThinking(
        score: data['SlowedThinking']['score_pensiero_rallentato'], 
        questionCount: data['SlowedThinking']['question_count'], 
        nWordsDoctor: data['SlowedThinking']['n_words_doctor'],  
        nWordsPatient: data['SlowedThinking']['n_words_patient'],  
        pauseBetweenWords: data['SlowedThinking']['pause_between_words'],  
        responseTime: data['SlowedThinking']['time_response']
        );

        return Report(logorrea: logorrea, 
        perseverance: perseverance, 
        ruminazione: ruminazione, 
        slowedThinking: slowedThinking, 
        data: DateTime.parse(data['dataVisita']), 
        id_paziente: data['idPaziente']);
  }

  toJson() {
    return {
      'dataVisita': dataVisita,
      'idPaziente': idPaziente,
      'Logorrea': {
        'score_logorrea_report' : logorreaObj.getScore,
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

