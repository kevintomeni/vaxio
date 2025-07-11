class AppConstants {
  static const String appName = 'Vaxio';
  static const String appVersion = '1.0.0';
  static const String baseUrl = 'http://192.168.2.38:5000/api'; // adapte si besoin
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String forgotPasswordEndpoint = '/auth/forgot-password';
  static const String resetPasswordEndpoint = '/auth/reset-password';
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String networkError = 'Erreur de connexion réseau';
  static const String serverError = 'Erreur du serveur';
  static const String unknownError = 'Erreur inconnue';
} 