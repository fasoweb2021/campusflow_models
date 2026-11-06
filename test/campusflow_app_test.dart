import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campusflow_models/main.dart';
import 'package:campusflow_models/screens/deadline_form_screen.dart';

void main() {
  testWidgets('opens a deadline and marks it as completed', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const CampusFlowApp());

    expect(find.text('Finaliser le projet Flutter'), findsOneWidget);
    await tester.tap(find.text('Finaliser le projet Flutter'));
    await tester.pumpAndSettle();

    expect(find.text('Détail'), findsOneWidget);
    await tester.tap(find.text('Marquer comme fait'));
    await tester.pumpAndSettle();

    expect(find.text('Échéance terminée'), findsOneWidget);
  });

  testWidgets('shows the list and detail together on a wide screen', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1000, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const CampusFlowApp());

    expect(find.text('À venir'), findsOneWidget);
    expect(find.text('Détail de l’échéance'), findsOneWidget);
    expect(find.text('Finaliser le projet Flutter'), findsWidgets);
  });

  testWidgets('validates required fields in the deadline form', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: DeadlineFormScreen()));

    await tester.ensureVisible(find.text('Ajouter l’échéance'));
    await tester.tap(find.text('Ajouter l’échéance'));
    await tester.pumpAndSettle();

    expect(find.text('Saisissez un titre.'), findsOneWidget);
    expect(find.text('Saisissez le nom du cours.'), findsOneWidget);
    expect(find.text('Choisissez une date limite.'), findsOneWidget);
  });
}
