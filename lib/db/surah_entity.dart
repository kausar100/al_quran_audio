import 'package:floor/floor.dart';

@entity
class SurahEntity {
  @primaryKey
  int? number;
  String? englishName;
  String? englishNameTranslation;
  int? numberOfAyahs;
  String? audio;
  String? revelationType;

  SurahEntity({
    this.number,
    this.englishName,
    this.englishNameTranslation,
    this.numberOfAyahs,
    this.audio,
    this.revelationType
  });

}

@entity
class AyatEntity {
  @primaryKey
  int? ayatNumberInQuran;
  int? surahNumber;
  String? textEdition;
  String? textArabic;
  int? numberInSurah;

  AyatEntity({
    this.ayatNumberInQuran,
    this.surahNumber,
    this.textEdition,
    this.textArabic,
    this.numberInSurah,
  });
}
