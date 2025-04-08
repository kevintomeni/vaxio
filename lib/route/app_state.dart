import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool _isLoading = false;
  String _currentRoute = '/';

  bool get isLoading => _isLoading;
  String get currentRoute => _currentRoute;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setCurrentRoute(String route) {
    _currentRoute = route;
    notifyListeners();
  }
}
