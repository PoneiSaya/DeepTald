abstract class ItemMisurabile {
  late int _finalScore;

  ItemMisurabile(int score) : _finalScore = score;

  get getScore => _finalScore;
  set setScore(int score) => _finalScore = score;
}
