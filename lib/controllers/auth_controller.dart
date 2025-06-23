import 'package:flutter/material.dart';
import 'package:vaxio/core/constants/app_constants.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class AuthController extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _error;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _currentUser != null;

  AuthController() {
    _loadUserFromStorage();
  }

  Future<void> _loadUserFromStorage() async {
    final storage = await StorageService.instance;
    _currentUser = storage.getUser();
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final response = await ApiService.instance.post(
        AppConstants.loginEndpoint,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final user = UserModel.fromJson(data['user']);
        final token = data['token'];

        // Save to storage
        final storage = await StorageService.instance;
        await storage.saveUser(user);
        await storage.saveToken(token);

        _currentUser = user;
        _setLoading(false);
        return true;
      } else {
        _setError('Email ou mot de passe incorrect');
        return false;
      }
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final response = await ApiService.instance.post(
        AppConstants.registerEndpoint,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        final data = response.data;
        final user = UserModel.fromJson(data['user']);
        final token = data['token'];

        // Save to storage
        final storage = await StorageService.instance;
        await storage.saveUser(user);
        await storage.saveToken(token);

        _currentUser = user;
        _setLoading(false);
        return true;
      } else {
        _setError('Erreur lors de l\'inscription');
        return false;
      }
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }
  
Future<bool> forgotPassword(String email) async {
  _setLoading(true);
  _clearError();
  try {
    final response = await ApiService.instance.post(
      AppConstants.forgotPasswordEndpoint,
      data: {
        'email': email,
      },
    );
    _setLoading(false);
    return response.data['success'] == true;
  } catch (e) {
    _setError(e.toString().replaceFirst('Exception: ', ''));
    return false;
  }
}

Future<bool> resetPassword(String email, String code, String newPassword, String confirmPassword) async {
  _setLoading(true);
  _clearError();
  try {
    final response = await ApiService.instance.post(
      AppConstants.resetPasswordEndpoint,
      data: {
        'email': email,
        'code': code,
        'password': newPassword,
        'confirm_password': newPassword,
      },
    );
    _setLoading(false);
    return response.data['success'] == true;
  } catch (e) {
    _setError(e.toString().replaceFirst('Exception: ', ''));
    return false;
  }
}

  Future<void> logout() async {
    _setLoading(true);
    
    try {
      final storage = await StorageService.instance;
      await storage.removeUser();
      await storage.removeToken();
      
      _currentUser = null;
      _setLoading(false);
    } catch (e) {
      _setError(e.toString());
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    _isLoading = false;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
} 