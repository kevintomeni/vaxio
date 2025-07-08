import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';

class OTPVerificationPage extends StatefulWidget {
  final String email;
  const OTPVerificationPage({super.key, required this.email});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  String _otp = '';
  String? _error;
  int _seconds = 130; // 2:10
  late final timer = Ticker(_tick);

  void _tick(Duration elapsed) {
    if (_seconds > 0) {
      setState(() => _seconds--);
    } else {
      timer.stop();
    }
  }

  @override
  void initState() {
    super.initState();
    timer.start();
  }

  @override
  void dispose() {
    timer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_seconds ~/ 60).toString().padLeft(1, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthOtpVerified) {
            // Navigue vers la page de changement de mot de passe
            Navigator.pushReplacementNamed(context, '/change-password', arguments: {
              'email': widget.email,
              'otp': _otp,
            });
          } else if (state is AuthError) {
            setState(() => _error = state.message);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 24),
                // Logo
                Icon(Icons.add, size: 48, color: Colors.blueAccent),
                const SizedBox(height: 32),
                const Text(
                  'Your Code',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Code sent to your Email',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 32),
                PinCodeTextField(
                  appContext: context,
                  length: 4,
                  onChanged: (value) => setState(() => _otp = value),
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(12),
                    fieldHeight: 60,
                    fieldWidth: 60,
                    activeColor: Colors.blueAccent,
                    selectedColor: Colors.blueAccent,
                    inactiveColor: Colors.grey.shade300,
                  ),
                ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(_error!, style: const TextStyle(color: Colors.red)),
                  ),
                const SizedBox(height: 16),
                Text(
                  '(${minutes}:${seconds})  Resend Code? ',
                  style: const TextStyle(color: Colors.black54),
                ),
                GestureDetector(
                  onTap: _seconds == 0
                      ? () {
                          // Ajoute ici l'action pour renvoyer le code
                          context.read<AuthBloc>().add(AuthResendOtpRequested(widget.email));
                          setState(() {
                            _seconds = 130;
                            timer.start();
                          });
                        }
                      : null,
                  child: Text(
                    'Click here',
                    style: TextStyle(
                      color: _seconds == 0 ? Colors.blue : Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return ElevatedButton(
                        onPressed: _otp.length == 4 && !isLoading
                            ? () {
                                setState(() => _error = null);
                                context.read<AuthBloc>().add(
                                  AuthOtpVerifyRequested(widget.email, _otp),
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : const Text('Verify', style: TextStyle(fontSize: 18)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Ajoute un ticker simple pour le timer
class Ticker {
  final void Function(Duration) onTick;
  Duration _elapsed = Duration.zero;
  bool _running = false;

  Ticker(this.onTick);

  void start() {
    _running = true;
    _tick();
  }

  void stop() {
    _running = false;
  }

  void _tick() async {
    while (_running) {
      await Future.delayed(const Duration(seconds: 1));
      if (_running) {
        _elapsed += const Duration(seconds: 1);
        onTick(_elapsed);
      }
    }
  }
}
