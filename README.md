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
- [Authentification Google (OAuth)](#authentification-google-oauth)
- [Récupération de mot de passe (email ou téléphone)](#récupération-de-mot-de-passe-email-ou-téléphone)

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

---

# Authentification Google (OAuth)

## Backend (Node.js)

- Nécessite les packages : `passport`, `passport-google-oauth20`, `google-auth-library`, `jsonwebtoken`.
- Ajoute les routes :
  - `GET /api/auth/google` : redirige vers Google
  - `GET /api/auth/google/callback` : callback web
  - `POST /api/auth/google-mobile` : pour Flutter/mobile (reçoit un idToken Google)
- Ajoute les variables dans `.env` :
  - `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET`, `GOOGLE_CALLBACK_URL`, `FRONTEND_URL`, `JWT_SECRET`
- Le backend vérifie le token Google, crée ou retrouve l'utilisateur, et retourne un JWT + user.

## Frontend (Flutter)

- Nécessite le package : `google_sign_in`
- Ajoute un bouton Google dans login et register (`SocialButton`)
- Utilise `GoogleSignIn().signIn()` pour obtenir l'idToken
- Envoie l'idToken à `/api/auth/google-mobile` via `ApiService`
- AuthCubit gère la connexion Google avec `loginWithGoogle`

## Exemple d'utilisation côté Flutter

```dart
final googleUser = await GoogleSignIn().signIn();
if (googleUser == null) return;
final googleAuth = await googleUser.authentication;
final idToken = googleAuth.idToken;
context.read<AuthCubit>().loginWithGoogle(idToken);
```

## Configuration Google Cloud

1. Va sur https://console.cloud.google.com/
2. Crée un projet, active "OAuth consent screen"
3. Crée des identifiants OAuth 2.0 (Web et Android/iOS)
4. Renseigne les bons redirect URIs (ex: `http://localhost:5000/api/auth/google/callback`)
5. Copie les clés dans `.env`

## Sécurité
- Ne partage jamais tes clés secrètes.
- Utilise HTTPS en production.

---

Pour toute question, consulte la doc officielle Google ou contacte le mainteneur du projet.

---

# Récupération de mot de passe (email ou téléphone)

## Fonctionnalité
- L'utilisateur peut demander la réinitialisation de son mot de passe en saisissant son email **ou** son numéro de téléphone.
- Un code OTP à 6 chiffres est envoyé par email ou SMS.
- L'utilisateur saisit ce code, puis entre un nouveau mot de passe et sa confirmation.

## Backend
- Endpoint `POST /api/auth/forgot-password` : accepte `{ email }` ou `{ phone }`.
- Endpoint `POST /api/auth/reset-password` : accepte `{ email|phone, code, password, confirmPassword }`.
- Le code OTP est valide 15 minutes.
- L'envoi de SMS est mocké (voir `utils/sendSMS.js`), à remplacer par Twilio ou autre.

## Frontend (Flutter)
- L'utilisateur saisit son email ou téléphone sur la page "Mot de passe oublié".
- Il reçoit un code OTP (6 chiffres) par email ou SMS.
- Il saisit ce code, puis son nouveau mot de passe et la confirmation.
- La logique est gérée dans `ForgotPasswordPage` et `VerifyEmailPage`.
- Le Cubit et ApiService gèrent les deux modes (email ou téléphone).

## Exemple d'appel API
```json
POST /api/auth/forgot-password
{
  "email": "user@mail.com"
}
// ou
{
  "phone": "+33612345678"
}

POST /api/auth/reset-password
{
  "email": "user@mail.com",
  "code": "123456",
  "password": "newpass",
  "confirmPassword": "newpass"
}
// ou
{
  "phone": "+33612345678",
  "code": "123456",
  "password": "newpass",
  "confirmPassword": "newpass"
}
```

## Sécurité
- Le code OTP expire au bout de 15 minutes.
- Le mot de passe doit être confirmé.
- Le numéro de téléphone doit être unique et au format international.

---

Pour intégrer l'envoi réel de SMS, remplace la fonction mock dans `utils/sendSMS.js` par Twilio, Nexmo, etc.
