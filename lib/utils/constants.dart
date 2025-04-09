class AppConstants {
  // Noms de routes
  static const String routeLoading = '/';
  static const String routeHome = '/home';
  static const String routeOnboarding = '/onboarding';
  static const String routeLoadingPage = '/loading';
  static const String routeSignIn = '/sign-in';
  static const String routeSignUp = '/sign-up';

  // Durées d'animation
  static const int animationDurationShort = 200;
  static const int animationDurationMedium = 300;
  static const int animationDurationLong = 500;

  // Messages
  static const String appName = 'Vaxio';
  static const String errorGeneric = 'Une erreur est survenue';
  static const String errorNetwork = 'Erreur de connexion';
  static const String errorTimeout = 'Délai d\'attente dépassé';

  // Formats de date
  static const String dateFormat = 'dd/MM/yyyy';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String timeFormat = 'HH:mm';

  // Limites
  static const int maxNameLength = 50;
  static const int maxDescriptionLength = 500;
  static const int maxPasswordLength = 32;
  static const int minPasswordLength = 8;

  // Configuration
  static const int splashScreenDuration = 2000;
  static const int apiTimeout = 30000;
  static const int cacheDuration = 3600; // 1 heure en secondes
}
