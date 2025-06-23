import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../constants/app_constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: Consumer<AuthController>(
        builder: (context, authController, child) {
          final user = authController.currentUser;
          
          if (user == null) {
            return const Center(
              child: Text('Aucun utilisateur connecté'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bienvenue !',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text('Nom: ${user.name}'),
                        Text('Email: ${user.email}'),
                        Text('Membre depuis: ${_formatDate(user.createdAt)}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Fonctionnalités disponibles:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: [
                      _buildFeatureCard(
                        context,
                        'Gestion des profils',
                        'Gérez vos informations personnelles',
                        Icons.person,
                      ),
                      _buildFeatureCard(
                        context,
                        'Paramètres',
                        'Configurez vos préférences',
                        Icons.settings,
                      ),
                      _buildFeatureCard(
                        context,
                        'Aide',
                        'Consultez l\'aide et le support',
                        Icons.help,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigation vers la fonctionnalité
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Fonctionnalité $title en cours de développement')),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _handleLogout(BuildContext context) async {
    final authController = context.read<AuthController>();
    await authController.logout();
    
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }
} 