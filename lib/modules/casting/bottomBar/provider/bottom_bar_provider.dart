import 'package:flutter/foundation.dart';

class BottomBarProvider extends ChangeNotifier{

  updateUi(){
    notifyListeners();
  }
}