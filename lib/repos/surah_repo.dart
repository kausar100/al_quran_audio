import 'dart:convert';
import 'package:al_quran_audio/db/database.dart';
import 'package:al_quran_audio/db/surah_dao.dart';
import 'package:al_quran_audio/db/surah_entity.dart';
import 'package:al_quran_audio/models/ayat.dart';
import 'package:al_quran_audio/models/surah.dart';
import 'package:al_quran_audio/services/api_call.dart';
import 'package:al_quran_audio/services/api_constant.dart';
import 'package:al_quran_audio/utils/extension_helper.dart';
import 'package:al_quran_audio/utils/helper.dart';

class APIRepository {
  final apiCall = APICall();
  final helper = Helper();

  Future<List<Surah>?> getAllSurah() async {
    try {
      final db =
          await $FloorAppDatabase.databaseBuilder('surah_database.db').build();
      final dao = db.surahDao;
      //check if data exist or not
      final info = await dao.getSurahInfo();
      if (info != null) {
        if (info.isNotEmpty && info.length == 114) {
          List<Surah> surahs = [];
          for (SurahEntity entity in info) {
            final surah = entity.toSurah();
            surahs.add(surah);
          }
          // print('data is fetched from db successfully!');
          return surahs;
        } else {
          return getSurahInfo(dao);
        }
      } else {
        return getSurahInfo(dao);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Surah>?> getSurahInfo(SurahDao dao) async {
    try {
      final response = await apiCall.getSurahNames();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;

        final info = data.map((s) => Surah.fromJson(s)).toList();
        //save to local database
        _storeSurahInfoToDB(info, dao);
        // print('data is fetched from internet successfully!');
        return info;
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }

  Future<List<Ayat>?> getSurahByNumber(int number, Edition language) async {
    try {
      final db =
          await $FloorAppDatabase.databaseBuilder('surah_database.db').build();
      final dao = db.surahDao;

      final List<AyatEntity>? translation =
          await dao.getSurahTranslationByNumber(number);

      //check if data exist or not
      if (translation != null) {
        if (translation.isNotEmpty) {
          List<Ayat> ayats = [];
          for (AyatEntity entity in translation) {
            final ayat = entity.toAyat();
            ayats.add(ayat);
          }
          // print('data is fetched from db successfully!');
          return ayats;
        } else {
          //db empty so need to fetch from internet
          try {
            return await fetchDataAndStoreToDB(number, language, dao);
          } catch (e) {
            rethrow;
          }
        }
      } else {
        //need to fetch from internet
        try {
          return await fetchDataAndStoreToDB(number, language, dao);
        } catch (e) {
          rethrow;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Ayat>?> getSurahTranslationByNumber(
      int number, Edition language) async {
    try {
      final response = await apiCall.getSurahById(number, language);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data']['ayahs'] as List;

        final ayats = data.map((s) => Ayat.fromJson(s)).toList();

        // print('ayat is fetched from internet successfully!');
        return ayats;
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }

  Future<void> _storeSurahInfoToDB(
      List<Surah> surahInfo, SurahDao surahDao) async {
    List<SurahEntity> entities = [];
    for (Surah info in surahInfo) {
      //convert to surah entity
      final entity = info.toSurahEntity();
      entities.add(entity);
    }
    await surahDao.insertSurahInfo(entities);
    // print('data is saved successfully!');
  }

  Future<void> _storeAyatToDB(
      List<Ayat> ayats, int surahNumber, SurahDao surahDao) async {
    List<AyatEntity> entities = [];
    for (Ayat ayat in ayats) {
      //convert to surah entity
      final entity = ayat.toAyatEntity(surahNumber);
      entities.add(entity);
    }
    await surahDao.insertSurahAyat(entities);
    // print('ayat is saved to db successfully!');
  }

  Future<List<Ayat>> fetchDataAndStoreToDB(
      int number, Edition language, dao) async {
    try {
      List<Ayat>? editionTranslation =
          await getSurahTranslationByNumber(number, language);
      List<Ayat>? arabicEdition =
          await getSurahTranslationByNumber(number, Edition.arabic);

      if (editionTranslation != null && arabicEdition != null) {
        //merge two and store to db
        final ayats =
             helper.mergedAyatList(editionTranslation, arabicEdition);

        //store to db
        await _storeAyatToDB(ayats, number, dao);
        return ayats;
      } else {
        throw Exception("Failed to get data");
      }
    } catch (e) {
      rethrow;
    }
  }
}
