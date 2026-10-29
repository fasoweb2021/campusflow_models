
/// Modèle représentant une tâche dans CampusFlow.
class Task {
  /// Identifiant unique de la tâche
  final int id;

  /// Titre ou description courte de la tâche
  final String title;

  /// Indique si la tâche est terminée (par défaut : false)
  final bool isCompleted;

  /// Constructeur constant avec paramètres nommés.
  /// Les attributs obligatoires sont marqués avec [required].
  const Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  /// Méthode [copyWith] permettant de créer une nouvelle instance
  /// en modifiant uniquement certains attributs (immuabilité).
  Task copyWith({
    int? id,
    String? title,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// Constructeur factory pour désérialiser un objet JSON (Map) en instance de [Task].
  /// Vérifie la validité des types et lève une [FormatException] en cas d'erreur.
  factory Task.fromJson(Map<String, dynamic> json) {
    // Validation des données entrantes
    if (json['id'] is! int ||
        json['title'] is! String ||
        (json.containsKey('isCompleted') &&
            json['isCompleted'] is! bool)) {
      throw const FormatException('Données Task invalides');
    }

    return Task(
      id: json['id'] as int,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  /// Convertit l'instance actuelle en Map clé/valeur pour la sérialisation JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }
}

