import 'package:bloc/bloc.dart';

class SignInState {
  final bool isLoading;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isRememberMeChecked;
  final bool isSignInSuccessful; // Nouvelle variable
  final String? errorMessage;

  SignInState({
    this.isLoading = false,
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isRememberMeChecked = false,
    this.isSignInSuccessful = false, // Initialisé à false
    this.errorMessage,
  });

  SignInState copyWith({
    bool? isLoading,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isRememberMeChecked,
    bool? isSignInSuccessful,
    String? errorMessage,
  }) {
    return SignInState(
      isLoading: isLoading ?? this.isLoading,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isRememberMeChecked: isRememberMeChecked ?? this.isRememberMeChecked,
      isSignInSuccessful: isSignInSuccessful ?? this.isSignInSuccessful,
      errorMessage: errorMessage,
    );
  }
}

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInState());

  void validateEmail(String email) {
    final isValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
    emit(state.copyWith(isEmailValid: isValid));
  }

  void validatePassword(String password) {
    final isValid = password.length >= 6;
    emit(state.copyWith(isPasswordValid: isValid));
  }

  void toggleRememberMe(bool value) {
    emit(state.copyWith(isRememberMeChecked: value));
  }

  Future<void> signIn(String email, String password) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSignInSuccessful: false));

    // Simule un appel API
    await Future.delayed(const Duration(seconds: 2));

    if (email == 'test@example.com' && password == '123456') {
      emit(state.copyWith(isLoading: false, isSignInSuccessful: true, errorMessage: null));
    } else {
      emit(state.copyWith(
        isLoading: false,
        isSignInSuccessful: false,
        errorMessage: 'Email ou mot de passe incorrect.',
      ));
    }
  }
}