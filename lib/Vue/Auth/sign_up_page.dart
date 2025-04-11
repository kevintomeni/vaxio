import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vaxio/utils/index.dart';

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
  bool _isPasswordVisible = false;
  bool _isEmailValid = false;

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
            padding: const EdgeInsets.all(AppDimensions.paddingM),
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
                  style:  TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Supprime le message après 3 secondes
    Future.delayed( Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:  EdgeInsets.all(AppDimensions.paddingM),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Image.asset("assets/images/logo.png",width: 100,), // Logo de l'application
                  // Title
                   Text('Welcome to Vaxio',
                    style: AppTextStyles.subtitle1,textAlign: TextAlign.center,),
                   SizedBox(height: 20),
          
                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon:  Icon(Icons.email_outlined),
                      suffixIcon: _isEmailValid
                          ?  Icon(Icons.check_circle, color: Colors.green)
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                      ),
                    ),
                    validator: _validateEmail,
                  ),
                   SizedBox(height: 16),
          
                  // Phone Field
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      prefixIcon:  Icon(Icons.phone_android_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                      ),
                    ),
                    validator: _validatePhone,
                  ),
                   SizedBox(height: 16),
          
                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon:  Icon(Icons.lock_outline),
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
                   SizedBox(height: 20),
                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                        ),
                      ),
                      onPressed: _submitForm,
                      child:  Text('Sign up', style: AppTextStyles.button),
                    ),
                  ),
                   SizedBox(height: 20),
          
                  // Sign In Link
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            context.go(AppConstants.routeSignIn);
                          },
                          child: const Text('Sign in'),
                        ),
                      ],
                    ),
                  ),
                   SizedBox(height: 20),
          
                  // Social Media Buttons
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