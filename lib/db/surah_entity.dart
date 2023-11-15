import 'package:floor/floor.dart';

@entity
class SurahEntity {
  @primaryKey
  int? number;
  String? englishName;
  String? englishNameTranslation;
  int? numberOfAyahs;

  SurahEntity({
    this.number,
    this.englishName,
    this.englishNameTranslation,
    this.numberOfAyahs,
  });

}

@entity
class AyatEntity {
  @primaryKey
  int? ayatNumber;
  int? surahNumber;
  String? textEdition;
  String? textArabic;
  int? numberInSurah;

  AyatEntity({
    this.ayatNumber,
    this.surahNumber,
    this.textEdition,
    this.textArabic,
    this.numberInSurah,
  });
}
