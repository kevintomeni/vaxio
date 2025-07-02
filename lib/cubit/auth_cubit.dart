import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../core/constants/app_constants.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    _loadUserFromStorage();
  }

  Future<void> _loadUserFromStorage() async {
    final storage = await StorageService.instance;
    final user = storage.getUser();
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final response = await ApiService.instance.post(
        AppConstants.loginEndpoint,
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final data = response.data;
        final user = UserModel.fromJson(data['user']);
        final token = data['token'];
        final storage = await StorageService.instance;
        await storage.saveUser(user);
        await storage.saveToken(token);
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError('Email ou mot de passe incorrect'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      final response = await ApiService.instance.post(
        AppConstants.registerEndpoint,
        data: {'name': name, 'email': email, 'password': password},
      );
      if (response.statusCode == 201) {
        final data = response.data;
        final user = UserModel.fromJson(data['user']);
        final token = data['token'];
        final storage = await StorageService.instance;
        await storage.saveUser(user);
        await storage.saveToken(token);
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError("Erreur lors de l'inscription"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> forgotPassword({String? email, String? phone}) async {
    emit(AuthLoading());
    try {
      final response = await ApiService.instance.forgotPassword(email: email, phone: phone);
      if (response['message'] != null && response['message'].toString().contains('Code OTP envoyé')) {
        emit(AuthForgotSuccess(email ?? phone ?? ''));
      } else {
        emit(AuthError('Erreur lors de l\'envoi du code'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPassword({String? email, String? phone, required String code, required String password, required String confirmPassword}) async {
    emit(AuthLoading());
    try {
      final response = await ApiService.instance.resetPassword(
        email: email,
        phone: phone,
        code: code,
        password: password,
        confirmPassword: confirmPassword,
      );
      if (response['message'] != null && response['message'].toString().contains('réinitialisé')) {
        emit(AuthResetSuccess());
      } else {
        emit(AuthError('Erreur lors de la réinitialisation'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      final storage = await StorageService.instance;
      await storage.removeUser();
      await storage.removeToken();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> loginWithGoogle(String idToken) async {
    emit(AuthLoading());
    try {
      final data = await ApiService.instance.loginWithGoogle(idToken);
      final user = UserModel.fromJson(data['user']);
      final token = data['token'];
      final storage = await StorageService.instance;
      await storage.saveUser(user);
      await storage.saveToken(token);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
} 