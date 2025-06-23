class AppConstants {
  static const String appName = 'Vaxio';
  static const String appVersion = '1.0.0';
  
  // API Endpoints
  static const String baseUrl = 'https://api.vaxio.com';
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  
  // Error Messages
  static const String networkError = 'Erreur de connexion réseau';
  static const String serverError = 'Erreur du serveur';
  static const String unknownError = 'Erreur inconnue';
} 