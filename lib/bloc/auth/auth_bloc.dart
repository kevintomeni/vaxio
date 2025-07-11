import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
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
    on<AuthOtpVerifyRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        // Utilise ApiService.instance comme pour les autres appels
        final data = await ApiService.instance.verifyOtp(
          email: event.email,
          code: event.otp,
        );
        if (data['success'] == true) {
          emit(AuthOtpVerified());
        } else {
          emit(AuthError(data['message'] ?? 'Erreur OTP'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<AuthResendOtpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final data = await ApiService.instance.forgotPassword(event.email);
        if (data['success'] == true) {
          emit(AuthForgotSuccess(event.email));
        } else {
          emit(AuthError('Erreur lors de la demande de renvoi du code'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<AuthChangePasswordRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final data = await ApiService.instance.changePassword(
          email: event.email,
          otp: event.otp,
          password: event.password,
          confirmPassword: event.confirmPassword,
        );
        if (data['success'] == true) {
          emit(AuthChangePasswordSuccess());
        } else {
          emit(AuthError(data['message'] ?? 'Erreur lors du changement de mot de passe'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }

  Future<void> _onLogin(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final data = await ApiService.instance.login(event.email, event.password);
      final user = UserModel.fromJson(data['user']);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegister(AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final data = await ApiService.instance.register(event.name, event.email, event.password);
      final user = UserModel.fromJson(data['user']);
      emit(AuthRegisterSuccess(user)); // Correction ici
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
      final data = await ApiService.instance.forgotPassword(event.email);
      if (data['success'] == true) {
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
      final data = await ApiService.instance.verifyOtp(
        email: event.email,
        code: event.code,
      );
      if (data['success'] == true) {
        emit(AuthVerifySuccess());
      } else {
        emit(AuthError(data['message'] ?? 'Erreur OTP'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
