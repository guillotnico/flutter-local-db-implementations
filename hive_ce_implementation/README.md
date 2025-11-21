flutter-local-db-implementations

Ce repo contient 3 mini-apps Flutter qui implémentent la même fonctionnalité  
avec 3 bases de données locales différentes, en Clean Architecture :

hive_implementation → Hive (Community Edition)

objectbox_implementation → ObjectBox

isar_implementation → Isar (Community Edition)

Chaque projet affiche et persiste une liste de fruits stockée en local.  
L’objectif est de comparer :

la structure du code (Domain / Data / Presentation),

l’ergonomie et les outils de debug/visualisation de chaque base locale.

🔧 Architecture commune

Tous les projets suivent la même structure :

lib/
  main.dart                # Composition (DI) et bootstrap

  domain/
    entities/              # Entités métier pures
    repositories/          # Interfaces de repository
    usecases/              # Cas d’usage

  data/
    models/                # Modèles de persistance (Hive/ObjectBox/Isar)
    datasources/           # Accès concret à la DB locale
    repositories/          # Implémentations des repositories

  presentation/
    providers/             # State management (ChangeNotifier / Provider)
    pages/                 # Pages Flutter
    widgets/               # Widgets réutilisables


Entité commune : Fruit

Dans tous les projets, l’entité métier est la même :

class Fruit {
  final String id;
  final String name;
  final String color;
  final double price;

  const Fruit({
    required this.id,
    required this.name,
    required this.color,
    required this.price,
  });
}


Un use case simple :

class GetAllFruitsUseCase {
  final FruitRepository repository;

  GetAllFruitsUseCase(this.repository);

  Future<List<Fruit>> call() => repository.getAllFruits();
}


Le repository lit toujours la DB locale et, si elle est vide, la remplit avec une liste de fruits “en dur”.

📦 Projet Hive – hive_implementation

Structure

Domain

domain/entities/fruit.dart

domain/repositories/fruit_repository.dart

domain/usecases/get_all_fruits.dart

Data

data/models/fruit_model.dart
→ Modèle annoté @HiveType, mapping FruitModel ⇆ Fruit

data/datasources/fruit_local_data_source.dart
→ Accès à un Box<FruitModel> (fruits_box), seed initial si besoin

data/repositories/fruit_repository_impl.dart
→ Retourne la liste des Fruit et gère l’initialisation de la box

Presentation

presentation/providers/fruit_provider.dart
→ ChangeNotifier : fruits, isLoading, errorMessage

presentation/pages/fruit_list_page.dart
→ Liste des fruits + pull-to-refresh

presentation/widgets/fruit_tile.dart
→ Affichage d’un fruit

Lancer le projet Hive

cd hive_implementation
flutter pub get
flutter run


Visualiser la base Hive (avec hive_ui)

Le projet utilise hive_ui pour explorer le contenu de la DB Hive.

Une classe Boxes centralise l’accès aux boxes :

class Boxes {
  static late Box<FruitModel> fruitBox;

  static Map<Box<dynamic>, FromJsonConverter> get allBoxes => {
    fruitBox: (json) => FruitModel.fromJson(json),
  };

  static void init(Box<FruitModel> box) {
    fruitBox = box;
  }
}


Dans la page principale, un bouton ouvre l’UI Hive :

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => HiveBoxesView(
      hiveBoxes: Boxes.allBoxes,
      onError: (msg) => debugPrint('Hive UI error: $msg'),
    ),
  ),
);


Depuis cette vue, tu peux :

parcourir les boxes,

ajouter / éditer / supprimer des lignes,

vider une box,

filtrer par colonne, etc.

C’est l’équivalent d’un petit admin DB intégré à l’app.

📦 Projet ObjectBox – objectbox_implementation

Structure

Domain

Identique au projet Hive : même Fruit, même interface de repository, même use case.

Data

data/models/fruit_model.dart
→ Modèle annoté @Entity() ObjectBox, avec :

obxId : ID interne ObjectBox (@Id())

id : ID métier (String)

mapping FruitModel ⇆ Fruit

data/datasources/objectbox_store.dart
→ Wrapper pour Store + Box<FruitModel>
→ Utilise openStore() généré dans lib/objectbox.g.dart

data/datasources/fruit_local_data_source.dart
→ Méthodes :

getFruits() → fruitBox.getAll()

saveFruits() → removeAll() + putMany()

getInitialFruits() → liste seed en dur

data/repositories/fruit_repository_impl.dart
→ Lit la DB, seed si elle est vide, renvoie List<Fruit>

Presentation

(Structure identique à Hive : seule la couche Data change.)

presentation/providers/fruit_provider.dart

presentation/pages/fruit_list_page.dart

presentation/widgets/fruit_tile.dart

Lancer le projet ObjectBox

Générer le code ObjectBox :

cd objectbox_implementation
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs


Lancer l’app :

flutter run


Visualiser la base ObjectBox

Deux approches possibles :

🧭 Option A — ObjectBox Browser (outil externe recommandé)

Installer ObjectBox Browser (voir la doc officielle).

Repérer le dossier de la DB ObjectBox :

sur desktop : souvent un dossier objectbox/ dans le répertoire de l’app,

sur mobile : dans le sandbox de l’app (via path_provider ou un explorateur de fichiers).

Ouvrir ce dossier avec ObjectBox Browser :

collection FruitModel,

exploration / édition / suppression des enregistrements.

🧪 Option B — Page de debug interne

Tu peux aussi ajouter une page Flutter type ObjectBoxDebugPage qui :

lit fruitBox.getAll(),

affiche chaque FruitModel dans une ListView.

Pratique pour vérifier rapidement le contenu de la DB sans installer d’outil externe.

📦 Projet Isar – isar_implementation

Structure

Domain

Toujours identique : mêmes entités, repositories abstraits, use case.

Data

data/models/fruit_model.dart
→ Modèle annoté @collection Isar, avec :

Id id : ID interne Isar (Isar.autoIncrement)

externalId : ID métier (String)

toEntity() / fromEntity() pour mapper vers Fruit

data/datasources/fruit_local_data_source.dart
→ Accès via les APIs générées :

isar.fruitModels.where().findAll()

isar.writeTxn() pour clear() + putAll()

seed initial via getInitialFruits()

data/repositories/fruit_repository_impl.dart
→ Même logique que Hive / ObjectBox :
lit la DB, seed si rien, renvoie une List<Fruit>.

Presentation

(Toujours la même UI / provider, seul le backend change.)

presentation/providers/fruit_provider.dart

presentation/pages/fruit_list_page.dart

presentation/widgets/fruit_tile.dart

Lancer le projet Isar

Générer le code Isar :

cd isar_implementation
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs


Lancer l’app :

flutter run


Visualiser la base Isar (Isar Inspector)

Isar fournit un Inspector intégré, accessible via une URL locale.

Dans main.dart, Isar est ouvert avec inspector: true :

final isar = await Isar.open(
  [FruitModelSchema],
  directory: dir.path,
  inspector: true, // activation de l’Inspector
);


Lancer l’app en debug :

flutter run


Dans la console, tu verras un message du type :

Isar Inspector listening on [http://127.0.0.1](http://127.0.0.1):xxxx


Ouvrir cette URL dans ton navigateur :

liste des collections (FruitModel),

visualisation/édition des documents,

filtres, recherche, etc.

Tant que l’app tourne en debug, l’Inspector est accessible via cette URL locale.

🧾 Récap – Visualisation des bases

DB

Dossier

Outil principal

Hive

hive_implementation

hive_ui → écran intégré dans l’app

ObjectBox

objectbox_implementation

ObjectBox Browser (outil externe) + debug UI

Isar

isar_implementation

Isar Inspector → URL locale en debug