# Architecture MVC - Vaxio

Cette application utilise une architecture MVC (Model-View-Controller) simple et maintenable.

## Structure des dossiers

```
lib/
├── constants/          # Constantes de l'application
├── controllers/        # Contrôleurs (logique métier)
├── models/            # Modèles de données
├── services/          # Services (API, stockage, etc.)
├── utils/             # Utilitaires et helpers
├── views/             # Vues (écrans de l'application)
└── widgets/           # Widgets réutilisables
```

## Composants principaux

### Models
- `UserModel` : Modèle pour les données utilisateur

### Controllers
- `AuthController` : Gestion de l'authentification

### Services
- `ApiService` : Gestion des appels API
- `StorageService` : Gestion du stockage local

### Views
- `LoginView` : Écran de connexion
- `HomeView` : Écran d'accueil

## Utilisation

1. **Créer un nouveau modèle** :
   ```dart
   // lib/models/example_model.dart
   class ExampleModel {
     final String id;
     final String name;
     
     ExampleModel({required this.id, required this.name});
   }
   ```

2. **Créer un nouveau contrôleur** :
   ```dart
   // lib/controllers/example_controller.dart
   class ExampleController extends ChangeNotifier {
     // Logique métier ici
   }
   ```

3. **Créer une nouvelle vue** :
   ```dart
   // lib/views/example_view.dart
   class ExampleView extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return Scaffold(
         // UI ici
       );
     }
   }
   ```

## Bonnes pratiques

1. Gardez les modèles simples et immuables
2. Utilisez les contrôleurs pour la logique métier
3. Les vues ne doivent contenir que la logique d'affichage
4. Utilisez les services pour les opérations externes
5. Centralisez les constantes dans le dossier constants 

## Authentification complète

- **Inscription** : `/auth/register` (POST)
- **Connexion** : `/auth/login` (POST)
- **Mot de passe oublié** : `/auth/forgot-password` (POST)
- **Réinitialisation du mot de passe** : `/auth/reset-password` (POST)
- **Session** : token JWT stocké localement, ajouté dans les headers
- **Déconnexion** : suppression du token et de l'utilisateur local
- **Gestion d'erreur** : tous les messages d'erreur du backend sont affichés à l'utilisateur dans l'UI (ex : email inexistant, mot de passe incorrect, etc.)
- **Tests** : des tests unitaires et widgets sont fournis pour garantir la robustesse des composants d'authentification

**Pour chaque nouvelle fonctionnalité, ajoute un test et documente le comportement attendu.** 

## Authentification - Mot de passe oublié (OTP par email)

### 1. Demander la réinitialisation
- **POST** `/api/auth/forgot-password`
- Body: `{ "email": "user@example.com" }`
- Réponse: `{ "message": "Code OTP envoyé par email" }`

### 2. Réinitialiser le mot de passe
- **POST** `/api/auth/reset-password`
- Body: `{ "email": "user@example.com", "code": "123456", "password": "newpass" }`
- Réponse: `{ "message": "Mot de passe réinitialisé avec succès" }`

### 3. Déconnexion
- **POST** `/api/auth/logout`
- Réponse: `{ "message": "Déconnexion réussie" }`

### 4. Swagger
- Documentation interactive disponible sur `/api-docs` 