import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';
import '../widgets/social_button.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _error;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterSuccess) {
          Navigator.pushReplacementNamed(
            context,
            '/role-selection',
            arguments: {'user': state.user},
          );
        }
        if (state is AuthError) {
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
            child: ListView(
              children: [
                  const SizedBox(height: 32),
                const Text('Register.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    labelText: 'User name *',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Nom requis' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    labelText: 'Password *',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Mot de passe requis";
                    if (v.length < 6) return "6 caractères min.";
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPassCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    labelText: 'Confirm Password *',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Nouveau mot de passe requis";
                    if (_passCtrl.text != _confirmPassCtrl.text) return "Mot de passe différent";
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                if (_error != null)
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                setState(() => _error = null);
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    AuthRegisterRequested(
                                      _nameCtrl.text,
                                      _emailCtrl.text,
                                      _passCtrl.text,
                                    ),
                                  );
                                }
                              },
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : const Text('Sign up'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                SocialButton(
                  label: 'S\'inscrire avec Google',
                  assetPath: 'assets/images/google.png',
                  onTap: () async {
                    setState(() => _error = null);
                    try {
                      final googleUser = await GoogleSignIn().signIn();
                      if (googleUser == null) return; // Annulé
                      final googleAuth = await googleUser.authentication;
                      final idToken = googleAuth.idToken;
                      if (idToken == null) throw Exception('Erreur Google');
                      context.read<AuthBloc>().add(
                        AuthGoogleSignInRequested(idToken),
                      );
                    } catch (e) {
                      setState(() => _error = e.toString());
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),  
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/login'),
                      child: const Text('Sign in', style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 
