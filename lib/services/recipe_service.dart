import 'package:dio/dio.dart';
import '../models/recipe_model.dart';
import '../core/constants/app_constants.dart';

class RecipeService {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  Future<List<Recipe>> fetchUserRecipes(String userId) async {
    final response = await _dio.get('/recipes/user/$userId');
    final List data = response.data['recipes'];
    return data.map((json) => Recipe.fromJson(json)).toList();
  }
} 