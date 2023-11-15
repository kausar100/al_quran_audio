import 'package:al_quran_audio/db/surah_entity.dart';
import 'package:al_quran_audio/models/ayat.dart';
import 'package:al_quran_audio/models/surah.dart';

extension ToEntity on Surah {
  SurahEntity toSurahEntity() {
    return SurahEntity(
        number: number,
        englishName: englishName,
        englishNameTranslation: englishNameTranslation,
        numberOfAyahs: numberOfAyahs);
  }
}

extension ToSurah on SurahEntity {
  Surah toSurah() {
    return Surah(
        number: number,
        englishName: englishName,
        englishNameTranslation: englishNameTranslation,
        numberOfAyahs: numberOfAyahs);
  }
}

extension ConvertToEntity on Ayat {
  AyatEntity toAyatEntity(int surahNumber) {
    return AyatEntity(
      ayatNumber: number,
      surahNumber: surahNumber,
      textEdition: text,
      textArabic: arabic,
      numberInSurah: numberInSurah,
    );
  }
}


extension ConvertToAyat on AyatEntity {
  Ayat toAyat() {
    return Ayat(
      number: ayatNumber,
      numberInSurah: numberInSurah,
      text: textEdition,
      arabic: textArabic,
    );
  }
}