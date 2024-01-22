import 'package:deep_tald/model/entity/Item.dart';

class Logorrea extends ItemMisurabile {
  late int _questionCount;
  late int _nWordsDoctor;
  late int _nWordsPatient;
  late int _interruptionCount;
  late double _avgResponseLength;
  late int _duration;
  late int _speakingTimePatient;
  late int _speakingTimeDoctor;

  Logorrea(
      {required int score,
      required int questionCount,
      required int nWordsDoctor,
      required int nWordsPatient,
      required int interruptionCount,
      required double avgResponseLength,
      required int duration,
      required int speakingTimePatient,
      required int speakingTimeDoctor})
      : 
        _questionCount = questionCount,
        _nWordsDoctor = nWordsDoctor,
        _nWordsPatient = nWordsPatient,
        _interruptionCount = interruptionCount,
        _avgResponseLength = avgResponseLength,
        _duration = duration,
        _speakingTimePatient = speakingTimePatient,
        _speakingTimeDoctor = speakingTimeDoctor,
        super(score);

  get questionCount => this._questionCount;
  set questionCount(value) => this._questionCount = value;
  get medico => this.medico;
  set medico(value) => this.medico = value;
  get paziente => this.paziente;
  set paziente(value) => this.paziente = value;
  get interruptionCount => this._interruptionCount;
  set interruptionCount(value) => this._interruptionCount = value;
  get avgResponseLength => this._avgResponseLength;
  set avgResponseLength(value) => this._avgResponseLength = value;
  get nWordsDoctor => this._nWordsDoctor;
  set nWordsDoctor(value) => this._nWordsDoctor = value;
  get nWordsPatient => this._nWordsPatient;
  set nWordsPatient(value) => this._nWordsPatient = value;
  get duration => this._duration;
  set duration(value) => this._duration = value;
  get speakingTimePatient => this._speakingTimePatient;
  set speakingTimePatient(value) => this._speakingTimePatient = value;
  get speakingTimeDoctor => this._speakingTimeDoctor;
  set speakingTimeDoctor(value) => this._speakingTimeDoctor = value;
}
