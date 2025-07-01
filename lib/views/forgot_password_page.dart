import 'package:flutter/material.dart';
import 'package:vaxio/controllers/auth_controller.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();
    final auth = AuthController();
    return Scaffold(
      appBar: AppBar(title: const Text('FORGOT PASSWORD.')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('Enter your email to receive the confirmation code'),
            const SizedBox(height: 16),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'email *'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: auth.isLoading
                  ? null
                  : () async {
                      final success = await auth.forgotPassword(emailCtrl.text);
                      if (success) {
                        // Naviguer vers la page de saisie du code
                        Navigator.pushNamed(context, '/verify', arguments: emailCtrl.text);
                      }
                    },
              child: auth.isLoading ? const CircularProgressIndicator() : const Text('Envoyer'),
            ),
            if (auth.error != null)
              Text(auth.error!, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
} 