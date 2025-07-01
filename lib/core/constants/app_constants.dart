class AppConstants {
  static const String appName = 'Vaxio';
  static const String appVersion = '1.0.0';
  
  // API Endpoints
  static const String baseUrl = 'http://localhost:3000/api';
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String forgotPasswordEndpoint = '/auth/forgot-password';
  static const String resetPasswordEndpoint = '/auth/reset-password';
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  
  // Error Messages
  static const String networkError = 'Erreur de connexion réseau';
  static const String serverError = 'Erreur du serveur';
  static const String unknownError = 'Erreur inconnue';
} 