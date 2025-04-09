import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vaxio/utils/constants.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _onboardingData = [
    _OnboardingData(
      imagePath: 'assets/images/splash1.png',
      titleText: 'Prenez le contrôle de votre santé',
      descriptionText:
          'Accédez aux dossiers cliniques, gérez les rendez-vous, les vaccins, les suivis et bien plus encore.',
    ),
    _OnboardingData(
      imagePath: 'assets/images/splash2.png',
      titleText: 'Accédez à vos données de santé',
      descriptionText:
          'Consultez vos résultats d\'analyses, vos prescriptions et vos antécédents médicaux en toute sécurité.',
    ),
    _OnboardingData(
      imagePath: 'assets/images/splash3.png',
      titleText: 'Restez informé',
      descriptionText:
          'Restez informé sur vos vaccinations, vos traitements et vos rendez-vous médicaux.',
    ),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    } else {
      context.go(AppConstants.routeSignIn);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) => _OnboardingPageContent(
                data: _onboardingData[index],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  TextButton(
                    onPressed: _previousPage,
                    child: const Text('Précédent'),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _nextPage,
                  child: Text(
                    _currentPage == _onboardingData.length - 1
                        ? 'Terminer'
                        : 'Suivant',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingData {
  final String imagePath;
  final String titleText;
  final String descriptionText;

  const _OnboardingData({
    required this.imagePath,
    required this.titleText,
    required this.descriptionText,
  });
}

class _OnboardingPageContent extends StatelessWidget {
  final _OnboardingData data;

  const _OnboardingPageContent({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(data.imagePath, width: 300),
          const SizedBox(height: 20),
          Text(
            data.titleText,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data.descriptionText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
