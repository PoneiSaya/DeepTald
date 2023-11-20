import 'package:deep_tald/model/entity/Item.dart';

class Logorrea extends ItemMisurabile {
  late String _resultString;
  late int _questionCount;
  late int _nWordsDoctor;
  late int _nWordsPatient;
  late int _interruptionCount;
  late double _avgResponseLength;

  Logorrea(
      {required int score,
      required String resultString,
      required int questionCount,
      required int nWordsDoctor,
      required int nWordsPatient,
      required int interruptionCount,
      required double avgResponseLength})
      : _resultString = resultString,
        _questionCount = questionCount,
        _nWordsDoctor = nWordsDoctor,
        _nWordsPatient = nWordsPatient,
        _interruptionCount = interruptionCount,
        _avgResponseLength = avgResponseLength,
        super(score);

  get resultString => this._resultString;
  set resultString(value) => this._resultString = value;
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
}
