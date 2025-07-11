import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _error;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthForgotSuccess) {
          // Navigue vers la page OTP avec l'email
          Navigator.pushNamed(context, '/verify', arguments: {'email': _emailCtrl.text});
        } else if (state is AuthError) {
          setState(() => _error = state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).maybePop(),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.black,
  ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text('Entrez votre email pour recevoir un code de réinitialisation'),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return "L'email est requis";
                    if (!v.contains('@')) return "Email invalide";
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                if (_error != null)
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;
                    return ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              setState(() => _error = null);
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  AuthForgotPasswordRequested(_emailCtrl.text),
                                );
                              }
                            },
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Envoyer le code'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}