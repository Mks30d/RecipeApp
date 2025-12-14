import 'package:flutter/material.dart';

class QuantityProvider extends ChangeNotifier {
  int _currentNumber = 1;
  List<double> _baseIngredientAmounts = [];
  int get currentNumber => _currentNumber;

  // set initial ingredient amounts
  void setBaseIngredientAmounts(List<double> amounts) {
    _baseIngredientAmounts = amounts;
    notifyListeners();
  }

  // update ingredient amounts based on quantity
  List<String> get updateIngredientAmounts {
    return _baseIngredientAmounts
        .map<String>((amount) => (amount * _currentNumber).toString())
        .toList();
  }

  // increase quantity
  void increaseQuantity() {
    _currentNumber++;
    notifyListeners();
  }

  // decrease quantity
  void decreaseQuantity() {
    if (_currentNumber > 1) {
      _currentNumber--;
      notifyListeners();
    }
  }
}
