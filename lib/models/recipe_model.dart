class Medicine {
  final String name;
  final String description;
  final String iconColor;
  Medicine({required this.name, required this.description, required this.iconColor});
  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
    name: json['name'],
    description: json['description'],
    iconColor: json['iconColor'],
  );
}

class Recipe {
  final String doctorName;
  final String doctorSpecialty;
  final List<Medicine> medicines;
  final String recommendations;
  final List<String> advices;
  Recipe({
    required this.doctorName,
    required this.doctorSpecialty,
    required this.medicines,
    required this.recommendations,
    required this.advices,
  });
  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    doctorName: json['doctorName'],
    doctorSpecialty: json['doctorSpecialty'],
    medicines: (json['medicines'] as List).map((e) => Medicine.fromJson(e)).toList(),
    recommendations: json['recommendations'],
    advices: List<String>.from(json['advices']),
  );
} 