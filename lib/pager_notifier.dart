import 'package:flutter/foundation.dart';

class PagerNotifier extends ChangeNotifier{

  int _value = 0;

  get position => _value;

  setupOnPosition(int newPosition){
    _value = newPosition;
    notifyListeners();
  }

}