import 'package:deep_tald/model/entity/Item.dart';

class SlowedThinking extends ItemMisurabile {
  late String _resultString;
  late int _questionCount;
  late int _nWordsDoctor;
  late int _nWordsPatient;
  late double _pauseBetweenWords;
  late double _responseTime;

  SlowedThinking(
      {required String resultString,
      required int score,
      required int questionCount,
      required int nWordsDoctor,
      required int nWordsPatient,
      required double pauseBetweenWords,
      required double responseTime})
      : _resultString = resultString,
        _questionCount = questionCount,
        _nWordsDoctor = nWordsDoctor,
        _nWordsPatient = nWordsPatient,
        _pauseBetweenWords = pauseBetweenWords,
        _responseTime = responseTime,
        super(score);

  get resultString => this._resultString;
  set resultString(value) => this._resultString = value;
  get questionCount => this._questionCount;
  set questionCount(value) => this._questionCount = value;
  get nWordsDoctor => this._nWordsDoctor;
  set nWordsDoctor(value) => this._nWordsDoctor = value;
  get nWordsPatient => this._nWordsPatient;
  set nWordsPatient(value) => this._nWordsPatient = value;
  get pauseBetweenWords => this._pauseBetweenWords;
  set pauseBetweenWords(value) => this._pauseBetweenWords = value;
  get responseTime => this._responseTime;
  set responseTime(value) => this._responseTime = value;
}
