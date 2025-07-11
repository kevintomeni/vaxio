import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';

class ChangePasswordPage extends StatefulWidget {
  final String email;
  final String otp;
  const ChangePasswordPage({super.key, required this.email, required this.otp});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _error;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthPasswordChanged) {
          Navigator.pushReplacementNamed(context, '/login');
        } else if (state is AuthError) {
          setState(() => _error = state.message);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text('Définir un nouveau mot de passe'),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passCtrl,
                  decoration: const InputDecoration(labelText: 'Nouveau mot de passe'),
                  obscureText: true,
                  validator: (v) => v == null || v.length < 6 ? '6 caractères min.' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmCtrl,
                  decoration: const InputDecoration(labelText: 'Confirmer le mot de passe'),
                  obscureText: true,
                  validator: (v) => v != _passCtrl.text ? 'Les mots de passe ne correspondent pas' : null,
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
                                  AuthChangePasswordRequested(
                                    widget.email,
                                    widget.otp,
                                    _passCtrl.text,
                                    _confirmCtrl.text,
                                  ),
                                );
                              }
                            },
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Changer le mot de passe'),
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