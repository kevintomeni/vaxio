part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {
  final UserModel user;
  AuthAuthenticated(this.user);
}
class AuthUnauthenticated extends AuthState {}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
class AuthForgotSuccess extends AuthState {
  final String contact;
  AuthForgotSuccess(this.contact);
}
class AuthResetSuccess extends AuthState {} 