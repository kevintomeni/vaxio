import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../services/recipe_service.dart';

class RecipesPage extends StatefulWidget {
  final String userId;
  const RecipesPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  List<Recipe> recipes = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final data = await RecipeService().fetchUserRecipes(widget.userId);
    setState(() {
      recipes = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Recipes', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFFF8F9FB),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (final recipe in recipes) ...[
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: const Icon(Icons.person, color: Colors.black),
                        radius: 20,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dr. ${recipe.doctorName}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(recipe.doctorSpecialty, style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  for (final med in recipe.medicines) ...[
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(int.parse(med.iconColor.replaceFirst('#', '0xff'))),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.medication, size: 32),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(med.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text(med.description, style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (recipe.recommendations.isNotEmpty) ...[
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Recommendations for treatment', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(recipe.recommendations, style: const TextStyle(color: Colors.grey)),
                          const SizedBox(height: 8),
                          for (final advice in recipe.advices)
                            Row(
                              children: [
                                const Icon(Icons.circle, size: 8),
                                const SizedBox(width: 8),
                                Text(advice),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                ],
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 32), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        currentIndex: 1,
        onTap: (i) {},
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
} 