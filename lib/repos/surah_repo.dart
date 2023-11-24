import 'dart:convert';
import 'package:al_quran_audio/db/database.dart';
import 'package:al_quran_audio/db/surah_dao.dart';
import 'package:al_quran_audio/db/surah_entity.dart';
import 'package:al_quran_audio/models/audio_quran.dart';
import 'package:al_quran_audio/services/api_call.dart';
import 'package:al_quran_audio/services/api_constant.dart';
import 'package:al_quran_audio/utils/extension_helper.dart';

class APIRepository {
  final apiCall = APICall();

  Future<List<AudioQuran>?> getAllSurah() async {
    try {
      final db =
          await $FloorAppDatabase.databaseBuilder('surah_database.db').build();
      final dao = db.surahDao;
      //check if data exist or not
      final info = await dao.getSurahInfo();
      if (info != null) {
        if (info.isNotEmpty && info.length == 114) {
          //get all surah
          List<AudioQuran> surahs = [];
          for (SurahEntity entity in info) {
            var surah = entity.toSurah();
            //get surah ayat
            final ayats = await dao.getSurahTranslationByNumber(entity.number!);
            if (ayats != null && ayats.isNotEmpty) {
              List<Ayahs> ayahs = [];
              for (AyatEntity ayat in ayats) {
                final ayah = ayat.toAyaths();
                ayahs.add(ayah);
              }
              surah.ayahs = ayahs;
            }
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

  Future<List<AudioQuran>?> getSurahInfo(SurahDao dao) async {
    try {
      final response = await apiCall.getFullQuran();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data']['surahs'] as List;

        final info = data.map((s) => AudioQuran.fromJson(s)).toList();
        //save to local database
        final withAudiourl = await _storeSurahInfoToDB(info, dao);
        final withArabicAyat = await _storeSurahAyatsToDB(withAudiourl, dao);
        print('data is fetched from internet successfully!');
        return withArabicAyat;
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }

  Future<List<Ayahs>?> getSurahByNumber(int number, Edition language) async {
    try {
      final db =
          await $FloorAppDatabase.databaseBuilder('surah_database.db').build();
      final dao = db.surahDao;

      final List<AyatEntity>? translation =
          await dao.getSurahTranslationByNumber(number);

      bool fetch = false;

      //check if data exist or not
      if (translation != null) {
        if (translation.isNotEmpty) {
          List<Ayahs> ayats = [];
          for (AyatEntity entity in translation) {
            final ayat = entity.toAyaths();

            if(ayat.text==null){
              //need to download translation
              fetch = true;
              break;
            }
            ayats.add(ayat);
          }
          if(fetch){
            try {
              return await fetchDataAndStoreToDB(number, language, dao);
            } catch (e) {
              rethrow;
            }
          }
          print('data is fetched from db successfully!');
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

  Future<List<Ayahs>?> getSurahTranslationByNumber(
      int number, Edition language) async {
    try {
      final response = await apiCall.getSurahById(number, language);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data']['ayahs'] as List;

        final ayats = data.map((s) => Ayahs.fromJson(s)).toList();

        print('ayat is fetched from internet successfully!');
        return ayats;
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }

  Future<List<AudioQuran>> _storeSurahInfoToDB(
      List<AudioQuran> surahInfo, SurahDao surahDao) async {
    List<SurahEntity> entities = [];
    List<AudioQuran> withAudioLink = List.from(surahInfo);
    int id = 0;
    for (AudioQuran info in surahInfo) {
      //convert to surah entity
      final audioUrl =
          "https://cdn.islamic.network/quran/audio-surah/128/ar.alafasy/${info.number}.mp3";

      //add audio url
      withAudioLink[id++].audio = audioUrl;

      final entity = info.toSurahEntity(audioUrl);
      entities.add(entity);
    }
    await surahDao.insertSurahInfo(entities);
    print('data is saved successfully!');
    return withAudioLink;
  }

  Future<List<Ayahs>> _storeAyatToDB(
      List<Ayahs> ayats, int surahNumber, SurahDao surahDao) async {
    List<Ayahs> ayahs = [];
    for (Ayahs ayat in ayats) {
      //convert to surah entity
      final withEdition = ayat.copyWith(ayat.text!);
      ayahs.add(withEdition);
      await surahDao.updateSurahAyat(ayat.text!, surahNumber);
    }
    return ayahs;
  }

  Future<List<Ayahs>> fetchDataAndStoreToDB(
      int number, Edition language, dao) async {
    try {
      List<Ayahs>? editionTranslation =
          await getSurahTranslationByNumber(number, language);

      if (editionTranslation != null) {
        //store to db
        final ayats = await _storeAyatToDB(editionTranslation, number, dao);
        return ayats;
      } else {
        throw Exception("Failed to get data");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AudioQuran>> _storeSurahAyatsToDB(List<AudioQuran> info, SurahDao dao) async {

    List<AudioQuran> withArabicText = List.from(info);
    int id = 0;

    for (AudioQuran surah in info) {

      List<AyatEntity> entities = [];
      List<Ayahs> arabicAyahs = [];
      final ayats = surah.ayahs!;
      for (Ayahs ayat in ayats) {
        //convert to surah entity
        final entity = ayat.toAyatEntity(surah.number!);

        //add arabic from json text
        final arabic = ayat.withArabic();

        entities.add(entity);
        arabicAyahs.add(arabic);
      }
      //add to list
      withArabicText[id++].ayahs = arabicAyahs;

      await dao.insertSurahAyat(entities);
      print('${surah.number}.${surah.name} ayats is inserted in db');
    }

    return withArabicText;
  }
}
