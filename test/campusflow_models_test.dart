import 'package:campusflow_models/campusflow_models.dart';
import 'package:test/test.dart';

void main() {
  group('Tests CampusFlow Models', () {
    // 1. Test de copyWith
    test('1. Test de copyWith : modifie un attribut tout en préservant les autres', () {
      const task = Task(
        id: 1,
        title: 'Apprendre Dart',
        isCompleted: false,
      );

      // On modifie uniquement isCompleted
      final updatedTask = task.copyWith(isCompleted: true);

      // Vérifications
      expect(updatedTask.id, equals(1));
      expect(updatedTask.title, equals('Apprendre Dart'));
      expect(updatedTask.isCompleted, isTrue);

      // L'instance d'origine reste inchangée (immuabilité)
      expect(task.isCompleted, isFalse);
    });

    // 2. Test de fromJson
    test('2. Test de fromJson : désérialise correctement une Map JSON en objet', () {
      final jsonCourse = {
        'id': 101,
        'title': 'Développement Mobile',
        'description': 'Introduction à Flutter et Dart',
      };

      final course = Course.fromJson(jsonCourse);

      expect(course.id, equals(101));
      expect(course.title, equals('Développement Mobile'));
      expect(course.description, equals('Introduction à Flutter et Dart'));
    });

    // 3. Test de l'erreur attendue
    test('3. Test de l\'erreur attendue : lève FormatException sur des données invalides', () {
      // Données invalides (par exemple : 'id' de type String au lieu de int)
      final invalidJsonUser = {
        'id': 'pas_un_id_valide',
        'name': 'Aliou',
        'email': 'aliou@campusflow.sn',
      };

      // On s'attend à ce que l'appel lève une FormatException
      expect(
        () => User.fromJson(invalidJsonUser),
        throwsA(isA<FormatException>()),
      );
    });

    // Test bonus pour le dépôt simulé (Future.delayed)
    test('Bonus. Test du dépôt simulé : charge les tâches de manière asynchrone', () async {
      final repository = CampusRepository();

      // Appel asynchrone avec un délai court pour les tests
      final tasks = await repository.fetchTasks(
        delay: const Duration(milliseconds: 10),
      );

      expect(tasks, isNotEmpty);
      expect(tasks.first.title, contains('cours de Dart'));
    });
  });
}
