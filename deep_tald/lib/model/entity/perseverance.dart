import 'package:deep_tald/model/entity/Item.dart';

class Perseverance extends ItemMisurabile {
  late int _questionCounter;
  late int _counter;
  late String _resultString;

  get questionCounter => this._questionCounter;
  set questionCounter(value) => this._questionCounter = value;
  get counter => this._counter;
  set counter(value) => this._counter = value;
  get resultString => this._resultString;
  set resultString(value) => this._resultString = value;

  Perseverance(
      {required int questionCounter,
      required int counter,
      required int score,
      required String resultString})
      : _questionCounter = questionCounter,
        _counter = counter,
        _resultString = resultString,
        super(score);
}
