import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../widgets/social_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _error;
  late AuthController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<AuthController>();
    ever<String?>(controller.errorRx, (err) {
      if (err != null) setState(() => _error = err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 32),
              const Text('Welcome Back.',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
              const SizedBox(height: 32),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20),),),
                  labelText: 'email *',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return "L'email est requis";
                  if (!v.contains('@')) return "Email invalide";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20),),),
                  labelText: 'Password *',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return "Mot de passe requis";
                  if (v.length < 6) return "6 caractères min.";
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/forgot'),
                  child: const Text('Forgot your password?'),
                ),
              ),
              const SizedBox(height: 16),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(_error!, style: const TextStyle(color: Colors.red)),
                ),
              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading
                      ? null
                      : () async {
                          setState(() => _error = null);
                          if (!_emailCtrl.text.contains('@')) {
                            setState(() => _error = "Format d'email invalide");
                            return;
                          }
                          if (_passCtrl.text.length < 6) {
                            setState(() => _error = "Mot de passe trop court");
                            return;
                          }
                          if (_formKey.currentState!.validate()) {
                            final success = await controller.login(
                              _emailCtrl.text,
                              _passCtrl.text,
                            );
                            if (success) Get.offAllNamed('/home');
                          }
                        },
                  child: controller.isLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Sign up'),
                ),
              )),
              const SizedBox(height: 16),
              SocialButton(
                label: 'Continuer avec Google',
                assetPath: 'assets/images/google.png',
                onTap: () async {
                  setState(() => _error = null);
                  try {
                    final googleUser = await GoogleSignIn().signIn();
                    if (googleUser == null) return; // Annulé
                    final googleAuth = await googleUser.authentication;
                    final idToken = googleAuth.idToken;
                    if (idToken == null) throw Exception('Erreur Google');
                    controller.loginWithGoogle(idToken);
                  } catch (e) {
                    setState(() => _error = e.toString());
                  }
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/register'),
                    child: const Text('Sign in', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 