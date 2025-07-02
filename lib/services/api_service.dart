import 'package:dio/dio.dart';
import 'package:vaxio/core/constants/app_constants.dart';
import '../models/user_model.dart';

class ApiService {
  late Dio _dio;
  static ApiService? _instance;

  ApiService._() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('REQUEST[${options.method}] => PATH: ${options.path}');
        handler.next(options);
      },
      onResponse: (response, handler) {
        print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
        handler.next(response);
      },
      onError: (error, handler) {
        print('ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
        handler.next(error);
      },
    ));
  }

  static ApiService get instance {
    _instance ??= ApiService._();
    return _instance!;
  }

  // Ajouter le token aux headers
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Supprimer le token des headers
  void removeAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? AppConstants.serverError);
      }
      throw Exception(AppConstants.networkError);
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      final response = await _dio.post('/auth/register', data: {
        'name': name,
        'email': email,
        'password': password,
      });

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? AppConstants.serverError);
      }
      throw Exception(AppConstants.networkError);
    }
  }

  Future<UserModel> getCurrentUser() async {
    try {
      final response = await _dio.get('/auth/me');
      return UserModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? AppConstants.serverError);
      }
      throw Exception(AppConstants.networkError);
    }
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> loginWithGoogle(String idToken) async {
    try {
      final response = await _dio.post('/auth/google-mobile', data: {
        'idToken': idToken,
      });
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? AppConstants.serverError);
      }
      throw Exception(AppConstants.networkError);
    }
  }

  Future<Map<String, dynamic>> forgotPassword({String? email, String? phone}) async {
    try {
      final response = await _dio.post('/auth/forgot-password', data: {
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
      });
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? AppConstants.serverError);
      }
      throw Exception(AppConstants.networkError);
    }
  }

  Future<Map<String, dynamic>> resetPassword({String? email, String? phone, required String code, required String password, required String confirmPassword}) async {
    try {
      final response = await _dio.post('/auth/reset-password', data: {
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
        'code': code,
        'password': password,
        'confirmPassword': confirmPassword,
      });
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? AppConstants.serverError);
      }
      throw Exception(AppConstants.networkError);
    }
  }

  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception(AppConstants.networkError);
      case DioExceptionType.badResponse:
        return Exception(AppConstants.serverError);
      default:
        return Exception(AppConstants.unknownError);
    }
  }

  static void setInstance(ApiService instance) {
    _instance = instance;
  }
} 