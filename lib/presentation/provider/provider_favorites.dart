import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:repaso/domain/entities/entities_people.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderFavorites extends ChangeNotifier{
  final List<Result> _favorites = [];

  List<Result> get favorites => List.unmodifiable(_favorites);

  ProviderFavorites(){
    _loadFromPrefer();
  }

 bool isFavorite(Result people) {
   return _favorites.any((b) => b.id == people.id);
 }

  void toogleFavorite(Result people) {
    if(isFavorite(people)){
      _favorites.removeWhere((b) => b.id == people.id);
    } else {
      _favorites.add(people);
    }
    notifyListeners();
    _saveToPrefs();
  }

  Future<void> _saveToPrefs() async{
    final prefer = await SharedPreferences.getInstance();
    final list = _favorites.map((b) => jsonEncode(b.toJson())).toList();
    await prefer.setStringList("favorites", list);

  }

  Future<void> _loadFromPrefer() async {
    final prefer = await SharedPreferences.getInstance();
    final list = prefer.getStringList("favorites") ?? [];
    _favorites.clear();
    _favorites.addAll(list.map((str) => Result.fromJson(jsonDecode(str))));
    notifyListeners();
  }

}
