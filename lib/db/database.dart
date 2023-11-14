import 'package:al_quran_audio/db/surah_dao.dart';
import 'package:al_quran_audio/db/surah_entity.dart';
import 'package:floor/floor.dart';

// required package imports
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'surah_dao.dart';
import 'surah_entity.dart';

part 'database.g.dart';

@Database(version: 1, entities: [SurahEntity, AyatEntity])
abstract class AppDatabase extends FloorDatabase{
  SurahDao get surahDao;
}