import 'package:al_quran_audio/db/surah_entity.dart';
import 'package:al_quran_audio/models/audio_quran.dart';

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

extension AyahstoAyatEntity on Ayahs{
  AyatEntity toAyatEntity(int surahNumber){
    return AyatEntity(
      ayatNumberInQuran: number,
      surahNumber: surahNumber,
      textArabic: text,
      numberInSurah: numberInSurah,
    );
  }

  Ayahs withArabic(){
    return Ayahs(
        number: number,
        audio: audio,
        arabic: text,
        numberInSurah: numberInSurah
    );
  }

  Ayahs copyWith(String edition){
    return Ayahs(
      number: number,
      audio: audio,
      text: edition,
      arabic: arabic,
      numberInSurah: numberInSurah
    );
  }
}



extension AyatEntityToAyahs on AyatEntity{
  Ayahs toAyaths(){
    return Ayahs(
      number: ayatNumberInQuran,
      text: textEdition,
      arabic: textArabic,
      numberInSurah: numberInSurah,
    );
  }
}