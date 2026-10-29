/// Modèle représentant un cours dans CampusFlow.
class Course {
  /// Identifiant unique du cours
  final int id;

  /// Titre ou nom du cours
  final String title;

  /// Description détaillée du cours
  final String description;

  /// Constructeur constant avec paramètres nommés obligatoires.
  const Course({
    required this.id,
    required this.title,
    required this.description,
  });

  /// Méthode [copyWith] permettant de cloner l'objet tout en modifiant
  /// certaines propriétés sans altérer l'instance d'origine.
  Course copyWith({
    int? id,
    String? title,
    String? description,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  /// Constructeur factory pour désérialiser une Map JSON en instance de [Course].
  /// Lève une [FormatException] si un champ est manquant ou n'a pas le bon type.
  factory Course.fromJson(Map<String, dynamic> json) {
    // Vérification des types attendus
    if (json['id'] is! int ||
        json['title'] is! String ||
        json['description'] is! String) {
      throw const FormatException('Données Course invalides');
    }

    return Course(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  /// Sérialise l'instance actuelle en Map pour l'encodage JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}

