import 'package:al_quran_audio/db/surah_entity.dart';
import 'package:al_quran_audio/models/audio_quran.dart';
import 'package:al_quran_audio/models/ayat.dart';

extension ToSurahEntity on AudioQuran {
  SurahEntity toSurahEntity(String audioUrl) {
    return SurahEntity(
        number: number,
        englishName: englishName,
        englishNameTranslation: englishNameTranslation,
        numberOfAyahs: ayahs!.length,
        audio: audioUrl,
        revelationType: revelationType);
  }
}

extension ToAudioQuran on SurahEntity {
  AudioQuran toSurah() {
    return AudioQuran(
        number: number,
        englishName: englishName,
        englishNameTranslation: englishNameTranslation,
        audio: audio,
        revelationType: revelationType);
  }
}

extension ConvertToEntity on Ayat {
  AyatEntity toAyatEntity(int surahNumber) {
    return AyatEntity(
      ayatNumberInQuran: number,
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
      number: ayatNumberInQuran,
      numberInSurah: numberInSurah,
      text: textEdition,
      arabic: textArabic,
    );
  }
}
