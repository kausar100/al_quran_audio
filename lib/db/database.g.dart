// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  SurahDao? _surahDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SurahEntity` (`number` INTEGER, `englishName` TEXT, `englishNameTranslation` TEXT, `numberOfAyahs` INTEGER, PRIMARY KEY (`number`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AyatEntity` (`ayatNumber` INTEGER, `surahNumber` INTEGER, `textEdition` TEXT, `textArabic` TEXT, `numberInSurah` INTEGER, PRIMARY KEY (`ayatNumber`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SurahDao get surahDao {
    return _surahDaoInstance ??= _$SurahDao(database, changeListener);
  }
}

class _$SurahDao extends SurahDao {
  _$SurahDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _surahEntityInsertionAdapter = InsertionAdapter(
            database,
            'SurahEntity',
            (SurahEntity item) => <String, Object?>{
                  'number': item.number,
                  'englishName': item.englishName,
                  'englishNameTranslation': item.englishNameTranslation,
                  'numberOfAyahs': item.numberOfAyahs
                }),
        _ayatEntityInsertionAdapter = InsertionAdapter(
            database,
            'AyatEntity',
            (AyatEntity item) => <String, Object?>{
                  'ayatNumber': item.ayatNumber,
                  'surahNumber': item.surahNumber,
                  'textEdition': item.textEdition,
                  'textArabic': item.textArabic,
                  'numberInSurah': item.numberInSurah
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SurahEntity> _surahEntityInsertionAdapter;

  final InsertionAdapter<AyatEntity> _ayatEntityInsertionAdapter;

  @override
  Future<List<SurahEntity>?> getSurahInfo() async {
    return _queryAdapter.queryList('SELECT * FROM SurahEntity',
        mapper: (Map<String, Object?> row) => SurahEntity(
            number: row['number'] as int?,
            englishName: row['englishName'] as String?,
            englishNameTranslation: row['englishNameTranslation'] as String?,
            numberOfAyahs: row['numberOfAyahs'] as int?));
  }

  @override
  Future<List<AyatEntity>?> getAllAyat() async {
    return _queryAdapter.queryList('SELECT * FROM AyatEntity',
        mapper: (Map<String, Object?> row) => AyatEntity(
            ayatNumber: row['ayatNumber'] as int?,
            surahNumber: row['surahNumber'] as int?,
            textEdition: row['textEdition'] as String?,
            textArabic: row['textArabic'] as String?,
            numberInSurah: row['numberInSurah'] as int?));
  }

  @override
  Future<List<AyatEntity>?> getSurahTranslationByNumber(int number) async {
    return _queryAdapter.queryList(
        'SELECT * FROM AyatEntity WHERE surahNumber = ?1',
        mapper: (Map<String, Object?> row) => AyatEntity(
            ayatNumber: row['ayatNumber'] as int?,
            surahNumber: row['surahNumber'] as int?,
            textEdition: row['textEdition'] as String?,
            textArabic: row['textArabic'] as String?,
            numberInSurah: row['numberInSurah'] as int?),
        arguments: [number]);
  }

  @override
  Future<void> insertSurahInfo(List<SurahEntity> infos) async {
    await _surahEntityInsertionAdapter.insertList(
        infos, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertSurahAyat(List<AyatEntity> ayats) async {
    await _ayatEntityInsertionAdapter.insertList(
        ayats, OnConflictStrategy.abort);
  }
}
