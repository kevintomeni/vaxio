import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vaxio/utils/index.dart';
import 'onboarding_cubit.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: BlocBuilder<OnboardingCubit, int>(
        builder: (context, currentPage) {
          final onboardingData = [
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

          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: PageController(initialPage: currentPage),
                    onPageChanged: (index) {
                      context.read<OnboardingCubit>().updatePage(index);
                    },
                    itemCount: onboardingData.length,
                    itemBuilder: (context, index) => _OnboardingPageContent(
                      data: onboardingData[index],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingM,
                    vertical: AppDimensions.paddingS,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentPage > 0)
                        TextButton(
                          onPressed: () {
                            context.read<OnboardingCubit>().previousPage();
                          },
                          child: const Text('Précédent'),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          onboardingData.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingS),
                            width: currentPage == index ? 12 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? Colors.blue
                                  : Colors.grey,
                              borderRadius:
                                  BorderRadius.circular(AppDimensions.radiusXS),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (currentPage < onboardingData.length - 1) {
                            context
                                .read<OnboardingCubit>()
                                .nextPage(onboardingData.length);
                          } else {
                            context.go(AppConstants.routeSignIn);
                          }
                        },
                        child: Text(
                          currentPage == onboardingData.length - 1
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
        },
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
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
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
