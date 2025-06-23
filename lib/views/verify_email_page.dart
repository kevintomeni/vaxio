import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaxio/controllers/auth_controller.dart';

class VerifyEmailPage extends StatelessWidget {
  final String email;

  const VerifyEmailPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final _codeCtrl = TextEditingController();
    final _newPassCtrl = TextEditingController();
    final _confirmPassCtrl = TextEditingController();
    final auth = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Réinitialiser votre mot de passe')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('Entrez le code de 5 chiffres que nous avons envoyé à votre email, puis votre nouveau mot de passe:'),
            const SizedBox(height: 16),
            TextField(
              controller: _codeCtrl,
              decoration: const InputDecoration(labelText: 'Code'),
              maxLength: 5,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _newPassCtrl,
              decoration: const InputDecoration(labelText: 'Nouveau mot de passe'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: auth.isLoading
                  ? null
                  : () async {
                      final success = await auth.resetPassword(email, _codeCtrl.text, _newPassCtrl.text, _confirmPassCtrl.text);
                      if (success) {
                        // Naviguer vers login ou afficher succès
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    },
              child: auth.isLoading ? CircularProgressIndicator() : Text('Réinitialiser'),
            ),
            if (auth.error != null)
              Text(auth.error!, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}