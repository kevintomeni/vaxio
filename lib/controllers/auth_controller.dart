import 'package:flutter/material.dart';
import 'package:vaxio/core/constants/app_constants.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import 'package:get/get.dart';

class AuthController extends ChangeNotifier {
  UserModel? _currentUser;
  final RxBool _isLoading = false.obs;
  final RxnString _error = RxnString();

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading.value;
  String? get error => _error.value;
  bool get isLoggedIn => _currentUser != null;
  RxnString get errorRx => _error;

  AuthController() {
    _loadUserFromStorage();
  }

  Future<void> _loadUserFromStorage() async {
    final storage = await StorageService.instance;
    _currentUser = storage.getUser();
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading.value = true;
    _error.value = null;

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
        _isLoading.value = false;
        return true;
      } else {
        _error.value = 'Email ou mot de passe incorrect';
        return false;
      }
    } catch (e) {
      _error.value = e.toString();
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _isLoading.value = true;
    _error.value = null;

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
        _isLoading.value = false;
        return true;
      } else {
        _error.value = 'Erreur lors de l\'inscription';
        return false;
      }
    } catch (e) {
      _error.value = e.toString();
      return false;
    }
  }
  
Future<bool> forgotPassword(String email) async {
  _isLoading.value = true;
  _error.value = null;
  try {
    final response = await ApiService.instance.post(
      AppConstants.forgotPasswordEndpoint,
      data: {
        'email': email,
      },
    );
    _isLoading.value = false;
    return response.data['success'] == true;
  } catch (e) {
    _error.value = e.toString().replaceFirst('Exception: ', '');
    return false;
  }
}

Future<bool> resetPassword(String email, String code, String newPassword, String confirmPassword) async {
  _isLoading.value = true;
  _error.value = null;
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
    _isLoading.value = false;
    return response.data['success'] == true;
  } catch (e) {
    _error.value = e.toString().replaceFirst('Exception: ', '');
    return false;
  }
}

  Future<void> logout() async {
    _isLoading.value = true;
    
    try {
      final storage = await StorageService.instance;
      await storage.removeUser();
      await storage.removeToken();
      
      _currentUser = null;
      _isLoading.value = false;
    } catch (e) {
      _error.value = e.toString();
    }
  }

  void _setLoading(bool loading) {
    _isLoading.value = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error.value = error;
    _isLoading.value = false;
    notifyListeners();
  }

  void _clearError() {
    _error.value = null;
    notifyListeners();
  }

  // Authentification Google
  Future<void> loginWithGoogle(String idToken) async {
    // TODO: Implémente la logique d'authentification Google ici
    // Exemple : envoie le token à ton backend, récupère l'utilisateur, etc.
    // Mets à jour isLoading, error, currentUser selon le résultat
  }
} 