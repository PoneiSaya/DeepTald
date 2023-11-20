import 'package:deep_tald/model/entity/Item.dart';

class Ruminazione extends ItemMisurabile {
  late String _resultStringSentiment;
  late String _resultStringTopic;
  late int _counterQuestions;
  late int _counter;
  late String _resultString;

  Ruminazione(
      {required int score,
      required String resultStringSentiment,
      required String resultStringTopic,
      required int counterQuestions,
      required int counter,
      required String resultString})
      : _resultStringSentiment = resultStringSentiment,
        _resultStringTopic = resultStringTopic,
        _counterQuestions = counterQuestions,
        _counter = counter,
        _resultString = resultString,
        super(score);

  get resultStringSentiment => _resultStringSentiment;
  set resultStringSentiment(value) => _resultStringSentiment = value;

  get resultStringTopic => _resultStringTopic;
  set resultStringTopic(value) => _resultStringTopic = value;

  get counterQuestions => _counterQuestions;
  set counterQuestions(value) => _counterQuestions = value;

  get counter => _counter;
  set counter(value) => _counter = value;

  get resultString => _resultString;
  set resultString(value) => _resultString = value;
}
