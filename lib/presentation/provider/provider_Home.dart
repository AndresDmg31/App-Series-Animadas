import 'package:flutter/material.dart';
import 'package:repaso/data/service/service_people.dart';
import 'package:repaso/domain/entities/entities_people.dart';

class ProviderHome extends ChangeNotifier {
  final _service = ServicePeople();

  People? _people;
  String? _error;

  People? get people => _people;
  String? get error => _error;

  Future<void> getData() async {
    try{
      final data = await _service.getData();
      _error = null;
      _people = data;
      notifyListeners();
    }catch (e){
      _error = e.toString();
      notifyListeners();
    }
  }

}