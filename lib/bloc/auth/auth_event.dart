import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  AuthLoginRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class AuthRegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  AuthRegisterRequested(this.name, this.email, this.password);

  @override
  List<Object?> get props => [name, email, password];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthForgotPasswordRequested extends AuthEvent {
  final String email;
  AuthForgotPasswordRequested(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthVerifyRequested extends AuthEvent {
  final String email;
  final String code;
  final String newPassword;
  AuthVerifyRequested(this.email, this.code, this.newPassword);

  @override
  List<Object?> get props => [email, code, newPassword];
}

class AuthGoogleSignInRequested extends AuthEvent {
  final String idToken;
  AuthGoogleSignInRequested(this.idToken);

  @override
  List<Object?> get props => [idToken];
}

class AuthChangePasswordRequested extends AuthEvent {
  final String email;
  final String otp;
  final String newPassword;
  AuthChangePasswordRequested(this.email, this.otp, this.newPassword);

  @override
  List<Object?> get props => [email, otp, newPassword];
}

class AuthOtpVerifyRequested extends AuthEvent {
  final String email;
  final String otp;
  AuthOtpVerifyRequested(this.email, this.otp);

  @override
  List<Object?> get props => [email, otp];
}

class AuthResendOtpRequested extends AuthEvent {
  final String email;
  AuthResendOtpRequested(this.email);

  @override
  List<Object?> get props => [email];
}
