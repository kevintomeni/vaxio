import 'package:dio/dio.dart';
import '../models/doctor_model.dart';
import '../core/constants/app_constants.dart';

class DoctorService {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  Future<List<Doctor>> fetchDoctors() async {
    final response = await _dio.get('/doctors');
    final List data = response.data['doctors'];
    return data.map((json) => Doctor.fromJson(json)).toList();
  }

  Future<List<String>> fetchCategories() async {
    final response = await _dio.get('/doctors/categories');
    final List data = response.data['categories'];
    return data.cast<String>();
  }

  Future<Doctor> fetchDoctorById(String id) async {
    final response = await _dio.get('/doctors/$id');
    return Doctor.fromJson(response.data['doctor']);
  }

  Future<List<Slot>> fetchDoctorSlots(String id) async {
    final response = await _dio.get('/doctors/$id/slots');
    final List data = response.data['slots'];
    return data.map((json) => Slot.fromJson(json)).toList();
  }
} 