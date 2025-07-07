import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/otp_input.dart';

class OTPPage extends StatefulWidget {
  final String contact; // email ou téléphone
  const OTPPage({super.key, required this.contact});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  String? _otp;
  String? _error;

  bool get isPhone => RegExp(r'^\+?[0-9]{7,15}').hasMatch(widget.contact);

  void _onCompleted(String code) {
    setState(() {
      _otp = code;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vérification OTP')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Entrez le code reçu sur ${isPhone ? 'votre téléphone' : 'votre email'}'),
            const SizedBox(height: 24),
            OTPInput(
              length: 6,
              onCompleted: (code) => _onCompleted(code),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(_error!, style: const TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _otp == null || _otp!.length != 6
                  ? null
                  : () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VerifyEmailPage(contact: widget.contact, otp: _otp!),
                        ),
                      );
                    },
              child: const Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }
}

class VerifyEmailPage extends StatelessWidget {
  final String contact; // email ou téléphone
  final String otp;

  const VerifyEmailPage({super.key, required this.contact, required this.otp});

  bool get isPhone => RegExp(r'^\+?[0-9]{7,15}').hasMatch(contact);

  @override
  Widget build(BuildContext context) {
    final newPassCtrl = TextEditingController();
    final confirmPassCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Réinitialiser votre mot de passe')),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthResetSuccess) {
            Navigator.pushReplacementNamed(context, '/login');
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
              const Text('Entrez votre nouveau mot de passe :'),
              const SizedBox(height: 16),
              TextField(
                controller: newPassCtrl,
                decoration: const InputDecoration(labelText: 'Nouveau mot de passe'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPassCtrl,
                decoration: const InputDecoration(labelText: 'Confirmer le mot de passe'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoading;
                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            final newPass = newPassCtrl.text.trim();
                            final confirmPass = confirmPassCtrl.text.trim();
                            if (isPhone) {
                              context.read<AuthCubit>().resetPassword(
                                phone: contact,
                                code: otp,
                                password: newPass,
                                confirmPassword: confirmPass,
                              );
                            } else {
                              context.read<AuthCubit>().resetPassword(
                                email: contact,
                                code: otp,
                                password: newPass,
                                confirmPassword: confirmPass,
                              );
                            }
                          },
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Réinitialiser'),
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