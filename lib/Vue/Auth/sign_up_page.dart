import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vaxio/utils/app_colors.dart';
import 'package:vaxio/utils/text_styles.dart';
import 'package:vaxio/utils/constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // Variable pour gérer la visibilité du mot de passe

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'L\'email est requis';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Entrez un email valide';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le numéro de téléphone est requis';
    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Entrez un numéro de téléphone valide';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le mot de passe est requis';
    } else if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inscription réussie')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Sign up', style: AppTextStyles.h1),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  prefixIconColor: AppColors.primary,
                  labelText: 'E-mail',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                ),
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone_android_outlined),
                  prefixIconColor: AppColors.primary,
                  labelText: 'Phone',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                ),
                validator: _validatePhone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible, // Contrôle la visibilité du mot de passe
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
                  prefixIconColor: AppColors.primary,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    color: AppColors.primary,
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible; // Inverse la visibilité
                      });
                    },
                  ),
                  labelText: 'Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                ),
                validator: _validatePassword,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    overlayColor: AppColors.background,
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: _submitForm,
                  child: const Text('Sign up', style: AppTextStyles.button),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      context.go(AppConstants.routeSignIn);
                    },
                    child: const Text('Sign in'),
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