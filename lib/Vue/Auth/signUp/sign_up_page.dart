import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vaxio/utils/index.dart';
import 'sign_up_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocProvider(
      create: (_) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.isSignUpSuccessful) {
            // Affiche un message de succès venant du haut
            _showSuccessMessage(context, 'Inscription réussie !');
            Future.delayed(const Duration(seconds: 2), () {
              context.go(AppConstants.routeHome); // Redirection après succès
            });
          } else if (state.errorMessage != null) {
            // Affiche un message d'erreur si l'inscription échoue
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<SignUpCubit>();

          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppDimensions.paddingL),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/logo.png", width: 100), // Logo
                        const SizedBox(height: 24),
                        const Text(
                          'Créez votre compte pour commencer.',
                          style: AppTextStyles.subtitle1,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),

                        // Email Field
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.email_outlined),
                            suffixIcon: state.isEmailValid
                                ? const Icon(Icons.check_circle, color: Colors.green)
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                            ),
                            errorText: !state.isEmailValid && emailController.text.isNotEmpty
                                ? 'Veuillez entrer un email valide'
                                : null, // Message d'erreur sous le champ
                          ),
                          onChanged: cubit.validateEmail,
                        ),
                        const SizedBox(height: 16),

                        // Phone Field
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            prefixIcon: const Icon(Icons.phone_android_outlined),
                            suffixIcon: state.isPhoneValid
                                ? const Icon(Icons.check_circle, color: Colors.green)
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                            ),
                            errorText: !state.isPhoneValid && phoneController.text.isNotEmpty
                                ? 'Veuillez entrer un numéro de téléphone valide'
                                : null, // Message d'erreur sous le champ
                          ),
                          onChanged: cubit.validatePhone,
                        ),
                        const SizedBox(height: 16),

                        // Password Field
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: state.isPasswordValid
                                ? const Icon(Icons.check_circle, color: Colors.green)
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                            ),
                            errorText: !state.isPasswordValid && passwordController.text.isNotEmpty
                                ? 'Le mot de passe doit contenir au moins 6 caractères'
                                : null, // Message d'erreur sous le champ
                          ),
                          onChanged: cubit.validatePassword,
                        ),
                        const SizedBox(height: 20),

                        // Sign Up Button
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                              ),
                            ),
                            onPressed: state.isEmailValid &&
                                    state.isPhoneValid &&
                                    state.isPasswordValid &&
                                    !state.isLoading
                                ? () {
                                    cubit.signUp(
                                      emailController.text,
                                      phoneController.text,
                                      passwordController.text,
                                    );
                                  }
                                : null, // Désactive le bouton si les champs ne sont pas valides
                            child: state.isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text('Sign Up', style: AppTextStyles.button),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Sign In Link
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account?'),
                              TextButton(
                                onPressed: () {
                                  context.go(AppConstants.routeSignIn);
                                },
                                child: const Text('Sign In'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Méthode pour afficher un message de succès venant du haut
  void _showSuccessMessage(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Supprime le message après 2 secondes
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}