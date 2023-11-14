import 'package:al_quran_audio/db/surah_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class SurahDao{

  @Query('SELECT * FROM SurahEntity')
  Future<List<SurahEntity>?> getSurahInfo();

  @Query('SELECT * FROM AyatEntity')
  Future<List<AyatEntity>?> getAllAyat();

  @Query('SELECT * FROM AyatEntity WHERE surahNumber = :number')
  Future<List<AyatEntity>?> getBanglaSurahByNumber(int number);

  @Query('SELECT * FROM AyatEntity WHERE surahNumber = :number')
  Future<List<AyatEntity>?> getArabicSurahByNumber(int number);

  @insert
  Future<void> insertSurahInfo(List<SurahEntity> infos);

  @insert
  Future<void> insertSurahAyat(List<AyatEntity> ayats);


}