import 'dart:convert';
import '../models/course.dart';
import '../models/task.dart';
import '../models/user.dart';

/// Dépôt simulé pour CampusFlow.
/// Il simule des appels réseau ou des requêtes vers une base de données
/// en utilisant [Future.delayed] et en décodant des données JSON.
class CampusRepository {
  /// Données brutes simulées au format JSON pour les tâches
  static const String _mockTasksJson = '''
  [
    {"id": 1, "title": "Réviser le cours de Dart", "isCompleted": true},
    {"id": 2, "title": "Créer les modèles CampusFlow", "isCompleted": false},
    {"id": 3, "title": "Écrire les tests unitaires", "isCompleted": false}
  ]
  ''';

  /// Données brutes simulées au format JSON pour les cours
  static const String _mockCoursesJson = '''
  [
    {"id": 101, "title": "Développement Mobile", "description": "Initiation à Dart et Flutter"},
    {"id": 102, "title": "Intelligence Artificielle", "description": "Modèles et algorithmes d'IA"}
  ]
  ''';

  /// Données brutes simulées au format JSON pour l'utilisateur
  static const String _mockUserJson = '''
  {
    "id": 1,
    "name": "Étudiant CampusFlow",
    "email": "etudiant@campusflow.sn"
  }
  ''';

  /// Simule la récupération d'un utilisateur connecté avec un délai réseau.
  /// [delay] : Durée de simulation (par défaut 500ms).
  Future<User> fetchCurrentUser({Duration delay = const Duration(milliseconds: 500)}) async {
    // Simulation du délai d'attente réseau
    await Future.delayed(delay);

    final Map<String, dynamic> data = jsonDecode(_mockUserJson) as Map<String, dynamic>;
    return User.fromJson(data);
  }

  /// Simule la récupération de la liste des cours avec un délai réseau.
  Future<List<Course>> fetchCourses({Duration delay = const Duration(milliseconds: 500)}) async {
    await Future.delayed(delay);

    final List<dynamic> list = jsonDecode(_mockCoursesJson) as List<dynamic>;
    return list
        .map((item) => Course.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Simule la récupération de la liste des tâches avec un délai réseau.
  Future<List<Task>> fetchTasks({Duration delay = const Duration(milliseconds: 500)}) async {
    await Future.delayed(delay);

    final List<dynamic> list = jsonDecode(_mockTasksJson) as List<dynamic>;
    return list
        .map((item) => Task.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Simule une requête réseau qui échoue (utile pour tester la gestion des erreurs).
  Future<void> fetchWithError({Duration delay = const Duration(milliseconds: 300)}) async {
    await Future.delayed(delay);
    throw Exception('Erreur de connexion au serveur CampusFlow');
  }
}
