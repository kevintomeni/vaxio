import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vaxio/utils/index.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isEmailValid = false;
  bool _isRememberMeChecked = false; // Variable pour gérer l'état de "Remember me"

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'L\'email est requis';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Entrez un email valide';
    }
    setState(() {
      _isEmailValid = true;
    });
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
      _showSuccessMessage('Inscription réussie');
    }
  }

  void _showSuccessMessage(String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0, // Position du message depuis le haut
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:  EdgeInsets.all(AppDimensions.paddingM),
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Supprime le message après 3 secondes
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
                  context.go(AppConstants.routeHome); // Redirection vers la page d'acceuille

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
        child: Center( // Centre tout le contenu verticalement
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo.png",width: 100,), // Logo de l'application
                  // Title
                  const Text('Welcome back! Please log in to your account.', style: AppTextStyles.subtitle1,textAlign: TextAlign.center,),
                  const SizedBox(height: 24),
                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined),
                      suffixIcon: _isEmailValid
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                      ),
                    ),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 10),

                  // Remember Me and Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Remember Me Checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: _isRememberMeChecked,
                            onChanged: (value) {
                              setState(() {
                                _isRememberMeChecked = value!;
                              });
                            },
                          ),
                          const Text('Remember me'),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          // Action pour "Forgot password?"
                        },
                        child: const Text('Forgot password?'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Log in Button
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                        ),
                      ),
                      onPressed: _submitForm,
                      child: const Text('Log in', style: AppTextStyles.button,),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Register Link
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {
                            context.go(AppConstants.routeSignUp);
                          },
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  ),

                  // Social Media Buttons
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: SizedBox(
                          width: 50,
                          child: Image.asset('assets/images/google.png'),
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(width: 30,),
                      IconButton(
                        icon: SizedBox(
                          width: 50,
                          child: Image.asset('assets/images/facebook.png'),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}