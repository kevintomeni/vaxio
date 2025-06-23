import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../models/user_model.dart';

class StorageService {
  static StorageService? _instance;
  late SharedPreferences _prefs;

  StorageService._();

  static Future<StorageService> get instance async {
    _instance ??= StorageService._();
    await _instance!._init();
    return _instance!;
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Token management
  Future<void> saveToken(String token) async {
    await _prefs.setString(AppConstants.tokenKey, token);
  }

  String? getToken() {
    return _prefs.getString(AppConstants.tokenKey);
  }

  Future<void> removeToken() async {
    await _prefs.remove(AppConstants.tokenKey);
  }

  // User management
  Future<void> saveUser(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await _prefs.setString(AppConstants.userKey, userJson);
  }

  UserModel? getUser() {
    final userJson = _prefs.getString(AppConstants.userKey);
    if (userJson != null) {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  Future<void> removeUser() async {
    await _prefs.remove(AppConstants.userKey);
  }

  // Generic storage methods
  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
} 