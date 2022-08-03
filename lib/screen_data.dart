import 'package:flutter/foundation.dart';

class ScreenData with ChangeNotifier {
  ScreenData({
    required int generation,
  }) : _generation = generation;

  int _generation = 5;

  int getGeneration() {
    return _generation;
  }

  void setGeneration(int generation) {
    _generation = generation;
    notifyListeners();
  }
}
