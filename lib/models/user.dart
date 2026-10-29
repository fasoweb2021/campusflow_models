/// Modèle représentant un utilisateur dans CampusFlow.
class User {
  /// Identifiant unique de l'utilisateur
  final int id;

  /// Nom complet de l'utilisateur
  final String name;

  /// Adresse e-mail de l'utilisateur
  final String email;

  /// Constructeur constant avec paramètres nommés obligatoires.
  const User({
    required this.id,
    required this.name,
    required this.email,
  });

  /// Méthode [copyWith] permettant de créer une nouvelle instance modifiée
  /// tout en préservant l'immuabilité de l'objet.
  User copyWith({
    int? id,
    String? name,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  /// Constructeur factory pour désérialiser une Map JSON en instance de [User].
  /// Valide la présence et le type des données, sinon lève une [FormatException].
  factory User.fromJson(Map<String, dynamic> json) {
    // Vérification des types attendus
    if (json['id'] is! int ||
        json['name'] is! String ||
        json['email'] is! String) {
      throw const FormatException('Données User invalides');
    }

    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  /// Transforme l'instance actuelle en Map clé/valeur pour le format JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

