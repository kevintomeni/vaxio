import 'package:bloc/bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../services/api_service.dart';
import '../../models/user_model.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLogin);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthLogoutRequested>(_onLogout);
    on<AuthForgotPasswordRequested>(_onForgotPassword);
    on<AuthVerifyRequested>(_onVerify);
  }

  Future<void> _onLogin(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await ApiService.instance.post(
        '/login',
        data: {'email': event.email, 'password': event.password},
      );
      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data['user']);
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError('Email ou mot de passe incorrect'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegister(AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await ApiService.instance.post(
        '/register',
        data: {'name': event.name, 'email': event.email, 'password': event.password},
      );
      if (response.statusCode == 201) {
        final user = UserModel.fromJson(response.data['user']);
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError('Erreur lors de l\'inscription'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onLogout(AuthLogoutRequested event, Emitter<AuthState> emit) {
    emit(AuthUnauthenticated());
  }

  Future<void> _onForgotPassword(AuthForgotPasswordRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await ApiService.instance.post(
        '/forgot-password',
        data: {'email': event.email},
      );
      if (response.data['success'] == true) {
        emit(AuthForgotSuccess(event.email));
      } else {
        emit(AuthError('Erreur lors de la demande de réinitialisation'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onVerify(AuthVerifyRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await ApiService.instance.post(
        '/verify',
        data: {'email': event.email, 'code': event.code, 'password': event.newPassword},
      );
      if (response.data['success'] == true) {
        emit(AuthVerifySuccess());
      } else {
        emit(AuthError('Erreur lors de la vérification'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
