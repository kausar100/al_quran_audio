import 'dart:convert';

import 'package:al_quran_audio/db/database.dart';
import 'package:al_quran_audio/db/surah_dao.dart';
import 'package:al_quran_audio/db/surah_entity.dart';
import 'package:al_quran_audio/models/ayat.dart';
import 'package:al_quran_audio/models/surah.dart';
import 'package:al_quran_audio/services/api_call.dart';
import 'package:al_quran_audio/services/api_constant.dart';
import 'package:al_quran_audio/utils/extension_helper.dart';

class APIRepository {
  final apiCall = APICall();

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
          print('data is fetched from db successfully!');
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
        _storeToDB(info, dao);
        print('data is fetched from internet successfully!');
        return info;
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }

  Future<List<Ayat>?> getSurahByNumber(int number, Edition language) async {
    try {
      final response = await apiCall.getSurahById(number, language);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data']['ayahs'] as List;

        return data.map((s) => Ayat.fromJson(s)).toList();
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }

  Future<List<Ayat>?> getArabicSurahByNumber(int number) async {
    try {
      final response = await apiCall.getArabicSurahById(number);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data']['ayahs'] as List;

        return data.map((s) => Ayat.fromJson(s)).toList();
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }

  Future<void> _storeToDB(List<Surah> surahInfo, SurahDao surahDao) async {
    List<SurahEntity> entities = [];
    for (Surah info in surahInfo) {
      //convert to surah entity
      final entity = info.toSurahEntity();
      entities.add(entity);
    }
    await surahDao.insertSurahInfo(entities);
    print('data is saved successfully!');
  }
}
