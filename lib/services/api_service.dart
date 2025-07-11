import 'package:dio/dio.dart';
import 'package:vaxio/core/constants/app_constants.dart';

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
  }

  static void setInstance(ApiService instance) {
    _instance = instance;
  }

  static ApiService get instance => _instance ??= ApiService._();

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

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    final response = await _dio.post('/auth/forgot-password', data: {'email': email});
    return response.data;
  }

  Future<Map<String, dynamic>> saveProfile({
    required String userId,
    required String gender,
    required String birthday,
    required String country,
    required String city,
  }) async {
    final response = await _dio.post('/profile', data: {
      'userId': userId,
      'gender': gender,
      'birthday': birthday,
      'country': country,
      'city': city,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String code,
  }) async {
    final response = await _dio.post('/auth/verify-otp', data: {
      'email': email,
      'code': code,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> changePassword({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await _dio.post('/auth/reset-password', data: {
      'email': email,
      'code': otp,
      'password': password,
      'confirmPassword': confirmPassword,
    });
    return response.data;
  }
} 