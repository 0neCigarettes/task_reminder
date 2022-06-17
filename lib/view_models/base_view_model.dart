import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool isBusy = false;

  void setBusy(bool value) {
    isBusy = value;
    notifyListeners();
  }
}
