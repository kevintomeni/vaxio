import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/onboarding_dot.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/images/splash1.png',
      'title': 'Prenez le contrôle de votre santé',
      'desc': 'Accédez aux dossiers cliniques, gérez les rendez-vous, les vaccins, les suivis et bien plus encore.',
    },
    {
      'image': 'assets/images/splash2.png',
      'title': 'Prenez le contrôle de votre santé',
      'desc': 'Accédez aux dossiers cliniques, gérez les rendez-vous, les vaccins, les suivis et bien plus encore.',
    },
    {
      'image': 'assets/images/splash3.png',
      'title': 'Prenez le contrôle de votre santé',
      'desc': 'Accédez aux dossiers cliniques, gérez les rendez-vous, les vaccins, les suivis et bien plus encore.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Image.asset(_pages[i]['image']!, height: 200),
                      const SizedBox(height: 32),
                      Text(
                        _pages[i]['title']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _pages[i]['desc']!,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (i) => OnboardingDot(isActive: i == _currentPage),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    TextButton(
                      onPressed: () {
                        _controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      child: const Text('Précédent'),
                    )
                  else
                    const SizedBox(width: 80),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage < _pages.length - 1) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      } else {
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    },
                    child: Text(_currentPage == _pages.length - 1 ? 'Terminer' : 'Suivant'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
