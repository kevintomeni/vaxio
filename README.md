# Vaxio - Documentation du Projet

## Table des matières
- [Architecture du projet](#architecture-du-projet)
- [Organisation des dossiers](#organisation-des-dossiers)
- [Thème et couleurs](#thème-et-couleurs)
- [Constantes](#constantes)
- [Gestion des routes](#gestion-des-routes)
- [SplashScreen et Onboarding](#splashscreen-et-onboarding)
- [Connexion Backend](#connexion-backend)
- [Ajout de nouvelles fonctionnalités](#ajout-de-nouvelles-fonctionnalités)
- [Bonnes pratiques](#bonnes-pratiques)

---

## Architecture du projet

Le projet suit une architecture modulaire et scalable, adaptée à la croissance de l'application et à l'ajout de nouvelles fonctionnalités. Les thèmes, couleurs, constantes, routes et widgets sont centralisés pour une maintenance facile.

---

## Organisation des dossiers

```
lib/
  main.dart
  app.dart
  core/
    theme/
      app_theme.dart
      app_colors.dart
      theme_notifier.dart
    constants/
      app_constants.dart
    routes/
      app_routes.dart
  controllers/
    auth_controller.dart
  models/
    user_model.dart
  services/
    api_service.dart
  views/
    splash_screen.dart
    onboarding_screen.dart
    login_view.dart
    register_page.dart
    forgot_password_page.dart
    verify_email_page.dart
    home_view.dart
  widgets/
    animated_logo.dart
    animated_text.dart
    onboarding_dot.dart
    custom_text_field.dart
    error_message.dart
    social_button.dart
```

---

## Thème et couleurs

Les couleurs principales sont centralisées dans `core/theme/app_colors.dart` :
- `primary` : bleu principal
- `primaryDark` : bleu foncé
- `background` : fond clair
- `text` : couleur du texte
- `accent` : couleur d'accentuation
- `error` : couleur d'erreur
- `grey` : gris pour les éléments secondaires

Le thème clair/sombre est géré dans `core/theme/app_theme.dart` et peut être changé dynamiquement via `ThemeNotifier`.

---

## Constantes

Toutes les constantes globales (nom de l'app, URL API, durée du splash, etc.) sont dans `core/constants/app_constants.dart`.

---

## Gestion des routes

Les routes sont centralisées dans `core/routes/app_routes.dart` :
- `/` : SplashScreen
- `/onboarding` : OnboardingScreen
- `/login` : LoginView
- `/register` : RegisterPage
- `/forgot` : ForgotPasswordPage
- `/verify` : VerifyEmailPage
- `/home` : HomeView

---

## SplashScreen et Onboarding

- **SplashScreen** : Animation du logo descendant et du texte montant, puis centrage.
- **Onboarding** : PageView avec illustrations, titre, description, dots animés, navigation Suivant/Précédent/Terminer.
- Les animations sont réalisées avec des widgets personnalisés dans `widgets/`.

---

## Connexion Backend

- Le service API (`services/api_service.dart`) gère la communication avec le backend Node.js/Express/MongoDB.
- Les endpoints sont configurés dans les constantes.
- La gestion d'état se fait via Provider/ChangeNotifier.

---

## Ajout de nouvelles fonctionnalités

- Crée un dossier ou fichier dans `views/` pour chaque nouvelle page.
- Ajoute la route dans `core/routes/app_routes.dart` et dans `app.dart`.
- Centralise les couleurs et constantes dans leurs fichiers respectifs.
- Pour le mode sombre, utilise `ThemeNotifier`.

---

## Bonnes pratiques

- **Centralise** tout ce qui est réutilisable (couleurs, widgets, constantes, routes).
- **Sépare** la logique métier (controllers) de l'UI (views).
- **Utilise** des widgets personnalisés pour les animations et composants récurrents.
- **Prépare** le projet pour le mode sombre et l'accessibilité.
- **Documente** chaque nouvelle fonctionnalité ou composant ajouté.

---

## Backend (Node.js/Express/MongoDB)

- Structure MVC (models, controllers, routes, middleware)
- Authentification JWT, gestion des utilisateurs, documentation Swagger
- Voir le dossier `backend/` pour le code complet

---

**Ce projet est prêt pour la production, facile à maintenir et à faire évoluer.**
