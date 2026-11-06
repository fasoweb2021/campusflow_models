# CampusFlow

CampusFlow est une application Flutter de gestion des échéances étudiantes,
accompagnée d’une bibliothèque Dart de modèles et d’un dépôt simulé.

## Fonctionnalités

- Liste des échéances à venir et des tâches terminées.
- Vue détaillée avec action « Marquer comme fait ».
- Formulaire de création avec validation et sélection de date.
- Affichage côte à côte de la liste et du détail sur les écrans d’au moins
  840 dp de largeur.
- Modèles Dart purs exportés par `package:campusflow_models/campusflow_models.dart`.

## Lancer l’application

Installez le SDK Flutter, puis exécutez depuis la racine du package :

```shell
flutter create --platforms=android,ios,web .
flutter pub get
flutter run -t lib/main.dart
```

La première commande ajoute les projets de plateforme Flutter au package Dart
existant.

Les échéances de l’interface sont actuellement conservées en mémoire et
réinitialisées au redémarrage.

## Tests

```shell
flutter test
```
