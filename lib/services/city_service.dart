import 'dart:convert';
import 'package:http/http.dart' as http;

class CityService {
  static const String _baseUrl = 'https://countriesnow.space/api/v0.1';
  
  /// Récupère toutes les villes d'un pays donné
  static Future<List<String>> getCitiesByCountry(String countryName) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/countries/cities'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'country': countryName}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['error'] == false && data['data'] != null) {
          final cities = List<String>.from(data['data']);
          return cities..sort(); // Trier les villes par ordre alphabétique
        }
      }
      
      // En cas d'erreur, retourner une liste vide
      return [];
    } catch (e) {
      print('Erreur lors de la récupération des villes: $e');
      return [];
    }
  }

  /// Récupère la liste de tous les pays
  static Future<List<String>> getAllCountries() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/countries'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['error'] == false && data['data'] != null) {
          final countries = data['data'] as List;
          final countryNames = countries
              .map((country) => country['country'] as String)
              .toList();
          return countryNames..sort(); // Trier par ordre alphabétique
        }
      }
      
      return [];
    } catch (e) {
      print('Erreur lors de la récupération des pays: $e');
      return [];
    }
  }

  /// Alternative avec une API plus simple (GeoDB Cities)
  static Future<List<String>> getCitiesByCountryAlternative(String countryName) async {
    try {
      // Utilisation de l'API GeoDB Cities (gratuite avec limite)
      final response = await http.get(
        Uri.parse('http://geodb-free-service.wirefreethought.com/v1/geo/cities?countryIds=$countryName&limit=10&offset=0&sort=-population'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null) {
          final cities = data['data'] as List;
          final cityNames = cities
              .map((city) => city['city'] as String)
              .toList();
          return cityNames..sort();
        }
      }
      
      return [];
    } catch (e) {
      print('Erreur avec l\'API alternative: $e');
      return [];
    }
  }
} 