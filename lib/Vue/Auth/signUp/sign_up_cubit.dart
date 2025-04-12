import 'package:bloc/bloc.dart';

class SignUpState {
  final bool isLoading;
  final bool isEmailValid;
  final bool isPhoneValid;
  final bool isPasswordValid;
  final bool isSignUpSuccessful;
  final String? errorMessage;

  SignUpState({
    this.isLoading = false,
    this.isEmailValid = false,
    this.isPhoneValid = false,
    this.isPasswordValid = false,
    this.isSignUpSuccessful = false,
    this.errorMessage,
  });

  SignUpState copyWith({
    bool? isLoading,
    bool? isEmailValid,
    bool? isPhoneValid,
    bool? isPasswordValid,
    bool? isSignUpSuccessful,
    String? errorMessage,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSignUpSuccessful: isSignUpSuccessful ?? this.isSignUpSuccessful,
      errorMessage: errorMessage,
    );
  }
}

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState());

  void validateEmail(String email) {
    final isValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
    emit(state.copyWith(isEmailValid: isValid));
  }

  void validatePhone(String phone) {
    final isValid = RegExp(r'^\d{10}$').hasMatch(phone);
    emit(state.copyWith(isPhoneValid: isValid));
  }

  void validatePassword(String password) {
    final isValid = password.length >= 6;
    emit(state.copyWith(isPasswordValid: isValid));
  }

  Future<void> signUp(String email, String phone, String password) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSignUpSuccessful: false));

    // Simule un appel API
    await Future.delayed(const Duration(seconds: 2));

    if (email == 'test@example.com' && phone == '0123456789' && password == '123456') {
      emit(state.copyWith(isLoading: false, isSignUpSuccessful: true, errorMessage: null));
    } else {
      emit(state.copyWith(
        isLoading: false,
        isSignUpSuccessful: false,
        errorMessage: 'Erreur lors de l\'inscription. Veuillez réessayer.',
      ));
    }
  }
}