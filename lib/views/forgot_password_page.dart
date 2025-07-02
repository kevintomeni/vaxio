import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final contactCtrl = TextEditingController();
  bool isPhone(String input) => RegExp(r'^\+?[0-9]{7,15}').hasMatch(input);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mot de passe oublié')),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthForgotSuccess) {
            Navigator.pushNamed(context, '/otp', arguments: state.contact);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text('Entrez votre email ou numéro de téléphone pour recevoir le code de confirmation'),
              const SizedBox(height: 16),
              TextField(
                controller: contactCtrl,
                decoration: const InputDecoration(labelText: 'Email ou téléphone *'),
              ),
              const SizedBox(height: 16),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoading;
                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            final value = contactCtrl.text.trim();
                            if (isPhone(value)) {
                              context.read<AuthCubit>().forgotPassword(phone: value);
                            } else {
                              context.read<AuthCubit>().forgotPassword(email: value);
                            }
                          },
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Envoyer'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
} 