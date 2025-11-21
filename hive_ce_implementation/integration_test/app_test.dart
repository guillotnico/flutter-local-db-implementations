import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// Import ton main.dart
import 'package:hive_implementation/main.dart' as app;

void logSection(String title) {
  // ignore: avoid_print
  print('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  // ignore: avoid_print
  print('🧪 [INTÉGRATION] $title');
  // ignore: avoid_print
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
}

void logStep(String message) {
  // ignore: avoid_print
  print('   👉 $message');
}

void logError(String message) {
  // ignore: avoid_print
  print('   ❌ $message');
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Lancement de l’app -> affiche la liste des fruits seedés',
        (WidgetTester tester) async {
      logSection('Démarrage de l’app Fruit avec Hive');

      try {
        // 1. Démarrer l’app avec le vrai main()
        logStep('Appel de app.main()');
        await app.main();

        logStep('On laisse l’UI se stabiliser (pumpAndSettle).');
        await tester.pumpAndSettle();

        // 2. Vérifier qu’on est bien sur la page principale
        logStep('Recherche du titre "Fruits".');
        final fruitsTitleFinder = find.text('Fruits');
        final fruitsTitleCount = fruitsTitleFinder.evaluate().length;

        if (fruitsTitleCount == 0) {
          logError(
              'Le titre "Fruits" n’est pas trouvé dans l’arbre de widgets. '
                  'Vérifie le title de l’AppBar ou la page home.');
        } else {
          logStep('Titre "Fruits" trouvé $fruitsTitleCount fois.');
        }

        expect(
          fruitsTitleFinder,
          findsOneWidget,
          reason:
          'La page principale devrait contenir exactement un titre "Fruits" dans l’AppBar.',
        );

        // 3. Vérifier la présence d’un fruit seedé
        logStep('Recherche du fruit "Apple" dans la liste.');
        final appleFinder = find.text('Apple');
        final appleCount = appleFinder.evaluate().length;

        if (appleCount == 0) {
          logError(
              'Aucune tuile "Apple" trouvée. '
                  'Possible causes : le seed Hive a changé, la box contient déjà d’anciennes données, '
                  'ou le texte affiché n’est pas exactement "Apple".');
        } else {
          logStep('Nombre de tuiles "Apple" trouvées : $appleCount');
        }

        expect(
          appleFinder,
          findsAtLeastNWidgets(1),
          reason:
          'La base seedée (getInitialFruits) doit contenir au moins un fruit "Apple".',
        );

        // 4. Vérifier qu’il y a bien une liste avec des ListTile
        logStep('Vérification de la présence de ListTile (lignes de fruits).');
        final listTileCount = find.byType(ListTile).evaluate().length;

        if (listTileCount == 0) {
          logError(
              'Aucun ListTile trouvé. La liste de fruits ne semble pas s’afficher comme prévu.');
        } else {
          logStep('Nombre de ListTile trouvés : $listTileCount');
        }

        expect(
          find.byType(ListTile),
          findsWidgets,
          reason:
          'La liste de fruits devrait afficher au moins un ListTile.',
        );

        // Si on arrive ici, tout va bien
        logStep('✅ Test d’intégration "démarrage + liste de fruits" OK');
      } catch (e, s) {
        logError('Échec du test d’intégration : $e');
        // ignore: avoid_print
        print(s);
        rethrow; // On relance pour que le test soit bien marqué en FAIL
      }
    },
  );

  testWidgets(
    'Pull-to-refresh sur la liste des fruits',
        (WidgetTester tester) async {
      logSection('Pull-to-refresh sur la liste des fruits');

      try {
        logStep('Lancement de l’app (app.main()).');
        await app.main();
        await tester.pumpAndSettle();

        // 1. Vérifier qu’on a une RefreshIndicator + une ListView
        logStep('Recherche du RefreshIndicator.');
        final refreshFinder = find.byType(RefreshIndicator);
        final refreshCount = refreshFinder.evaluate().length;
        if (refreshCount == 0) {
          logError(
              'Aucun RefreshIndicator trouvé. Vérifie que la liste est bien '
                  'enveloppée dans un RefreshIndicator dans FruitListPage.');
        } else {
          logStep('RefreshIndicator trouvé ($refreshCount instance(s)).');
        }

        expect(
          refreshFinder,
          findsOneWidget,
          reason:
          'La page liste des fruits devrait contenir un RefreshIndicator autour de la ListView.',
        );

        logStep('Recherche de la ListView.');
        final listFinder = find.byType(ListView);
        final listCount = listFinder.evaluate().length;
        if (listCount == 0) {
          logError(
              'Aucune ListView trouvée. Vérifie que FruitListPage construit bien '
                  'un ListView (ou ListView.separated) lorsque des fruits sont présents.');
        } else {
          logStep('ListView trouvée ($listCount instance(s)).');
        }

        expect(
          listFinder,
          findsOneWidget,
          reason:
          'La page liste des fruits devrait contenir une ListView principale.',
        );

        // 2. Vérifier l’état AVANT refresh
        final listTileBefore = find.byType(ListTile).evaluate().length;
        if (listTileBefore == 0) {
          logError(
              'Avant le pull-to-refresh, aucun ListTile n’est présent. '
                  'Soit la DB est vide, soit le seed ne s’est pas fait comme prévu.');
        } else {
          logStep('Avant refresh : $listTileBefore ListTile trouvés.');
        }

        expect(
          listTileBefore > 0,
          true,
          reason:
          'Avant le refresh, il doit déjà y avoir au moins un fruit affiché (ListTile).',
        );

        // 3. Drag pour déclencher le RefreshIndicator
        logStep('Déclenchement du pull-to-refresh (drag vers le bas).');
        // On drag sur la ListView (ou sur le RefreshIndicator)
        await tester.drag(listFinder, const Offset(0, 200));
        await tester.pump(); // déclenche l’animation de refresh

        logStep('Attente de la fin du refresh (pumpAndSettle).');
        await tester.pumpAndSettle();

        // 4. Vérifier l’état APRÈS refresh
        final listTileAfter = find.byType(ListTile).evaluate().length;
        if (listTileAfter == 0) {
          logError(
              'Après le pull-to-refresh, il n’y a plus aucun ListTile. '
                  'Le refresh semble casser le chargement des fruits.');
        } else {
          logStep('Après refresh : $listTileAfter ListTile trouvés.');
        }

        expect(
          listTileAfter > 0,
          true,
          reason:
          'Après un pull-to-refresh, la liste doit toujours afficher au moins un fruit (ListTile).',
        );

        logStep('✅ Test d’intégration "pull-to-refresh" OK');
      } catch (e, s) {
        logError('Échec du test d’intégration (pull-to-refresh) : $e');
        // ignore: avoid_print
        print(s);
        rethrow;
      }
    },
  );

}
