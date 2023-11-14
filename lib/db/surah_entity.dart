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
  int? surahNumber;
  String? textBangla;
  String? textArabic;
  int? numberInSurah;

  AyatEntity({
    this.surahNumber,
    this.textBangla,
    this.textArabic,
    this.numberInSurah,
  });
}
