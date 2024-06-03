import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  // Example state variable
  String _exampleState = 'Welcome to Shoesly!';

  String get exampleState => _exampleState;

  void updateExampleState(String newState) {
    _exampleState = newState;
    notifyListeners();
  }
}
