import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  String _selectedService = ' ';

  String get selectedService => _selectedService;

  set selectedService(String value) {
    _selectedService = value;
    notifyListeners();
  }
}
