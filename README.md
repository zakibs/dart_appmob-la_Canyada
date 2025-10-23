# app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



                Chicken La Canyada - Application Mobile



Une application Flutter complète de commande et livraison pour le restaurant Chicken La Canyada.



                📱 Aperçu du Projet



Cette application permet aux clients de :

Parcourir le menu complet du restaurant

Commander en ligne avec personnalisation

Suivre leurs commandes en temps réel

Gérer leur profil et historique



                🏗 Architecture du Projet



Structure Technique
text
lib/
├── core/           # Code métier partagé
│   ├── constants/  # Constantes et configurations
│   ├── themes/     # Thèmes et design system
│   ├── utils/      # Utilitaires et helpers
│   └── widgets/    # Composants réutilisables
├── data/           # Couche données
│   ├── models/     # Modèles de données
│   ├── repositories/# Abstraction des sources de données
│   └── datasources/# Implémentation des APIs
├── domain/         # Logique métier
│   ├── entities/   # Entités métier
│   ├── repositories/# Interfaces des repositories
│   └── usecases/   # Cas d'utilisation
├── presentation/   # Interface utilisateur
│   ├── pages/      # Écrans de l'application
│   ├── providers/  # Gestion d'état avec Riverpod
│   └── widgets/    # Widgets spécifiques aux pages
└── main.dart       # Point d'entrée de l'application



               Technologies Utilisées



Flutter 3.19+ avec Dart 3

Riverpod pour la gestion d'état

Architecture Clean avec séparation des concerns

Material Design 3 pour l'UI

SharedPreferences pour la persistance locale

Google Fonts pour la typographie



              🎨 Design System



Palette de Couleurs

dart
class AppColors {
  static const Color primary = Color(0xFFD35400);    // Orange principal
  static const Color secondary = Color(0xFF8B4513);  // Marron secondaire
  static const Color accent = Color(0xFFFFA726);     // Orange d'accent
  static const Color background = Color(0xFFFEF9E7); // Fond beige
  static const Color surface = Color(0xFFFFFFFF);    // Surface blanche
}


Typographie
Police principale : Inter (via Google Fonts)

Hiérarchie claire avec différentes weights et tailles



                📊 Fonctionnalités Implémentées
                ✅ Fonctionnalités Principales



Splash Screen & Onboarding

Écran de démarrage animé

Présentation du restaurant

Navigation et UI

Design responsive Material 3

Navigation fluide entre les écrans

Thème clair/sombre persistant

Catalogue Produits

Affichage par catégories

Recherche et filtrage

Détails complets des produits

Gestion du Panier

Ajout/retrait de produits

Calcul automatique des totaux

Persistance locale

Système de Commandes

Processus de checkout

Confirmation de commande

Historique des commandes



                🚧 Fonctionnalités Futures



Paiement en ligne (Stripe)

Géolocalisation et livraison

Notifications push

Authentification utilisateur

Backend Firebase

Suivi commande en temps réel



                🗂 Structure des Données



Modèles Principaux
dart
// Produit du menu
class MenuItem {
  String id, name, description, category, imageUrl;
  double price;
  List<String>? options;
}

// Article du panier
class CartItem {
  String id;
  MenuItem menuItem;
  int quantity;
  String? selectedOption;
}

// Commande
class Order {
  String id;
  List<CartItem> items;
  double total;
  DateTime orderDate;
  OrderStatus status;
}



                🔧 Installation et Configuration



Prérequis
Flutter SDK 3.19+

Dart 3.0+

Android Studio / VS Code

Étapes d'Installation
Cloner le projet

bash
git clone [repository-url]
cd chicken_la_canyada
Installer les dépendances

bash
flutter pub get
Configurer les assets (optionnel)

bash
# Créer la structure de dossiers
mkdir -p assets/images/categories
mkdir -p assets/images/products
Lancer l'application

bash
flutter run
Configuration des Assets
Placez vos images dans :

assets/images/categories/ - Images des catégories

assets/images/products/ - Images des produits



                🧪 Tests



Exécuter les tests
bash
# Tous les tests
flutter test

# Tests spécifiques
flutter test test/widget_test.dart
Couverture des Tests
Tests widget pour les écrans principaux

Tests unitaires pour les providers

Tests d'intégration pour les flux utilisateur



               🚀 Déploiement



Build pour Production
bash
# Android
flutter build apk --release

# Web
flutter build web --release

# Windows
flutter build windows --release
Checklist Pré-déploiement
Tests passants

Assets optimisés

Performance analysée

Accessibilité vérifiée

Sécurité validée



                📈 Performance et Optimisations



Optimisations Implémentées
Lazy loading des listes

Cache d'images avec cached_network_image

Widgets const quand possible

État local pour éviter rebuilds inutiles

Métriques Clés
Taille APK : ~15MB

Temps de lancement : < 2s

FPS moyen : 60fps



                🔒 Sécurité



Mesures Implémentées
Validation des données côté client

Stockage sécurisé des préférences

Gestion sécurisée des états d'authentification



                🌐 Internationalisation



Support des Langues
Français (par défaut)

Anglais (prévu)

Structure i18n :

text
lib/l10n/
├── app_fr.arb
└── app_en.arb



                🐛 Dépannage



Problèmes Courants
Erreurs d'assets

bash
flutter clean
flutter pub get
Problèmes de performance

bash
flutter analyze
flutter build apk --analyze-size
Tests échoués

bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/



               🤝 Contribution


               
Guide de Contribution
Fork le projet

Créer une branche feature

Commiter les changements

Push vers la branche

Créer une Pull Request

Standards de Code
Respect des conventions Dart/Flutter

Code commenté pour les parties complexes

Tests unitaires pour les nouvelles fonctionnalités

📞 Support
Documentation
Documentation Flutter

API Reference

Contact Développement
Email : zakariasabah2000@gmail.com

Issues : zakibs



                📄 Licence



Ce projet est sous licence MIT. Voir le fichier LICENSE pour plus de détails.

Développé avec ❤️ pour Chicken La Canyada