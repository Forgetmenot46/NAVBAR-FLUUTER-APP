import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  List<String> _favoriteFoods = [];

  List<String> get favoriteFoods => _favoriteFoods;

  void addFavorite(String food) {
    if (!_favoriteFoods.contains(food)) {
      _favoriteFoods.add(food);
      notifyListeners();
    }
  }

  void removeFavorite(String food) {
    if (_favoriteFoods.contains(food)) {
      _favoriteFoods.remove(food);
      notifyListeners();
    }
  }

  bool isFavorite(String food) {
    return _favoriteFoods.contains(food);
  }
}
