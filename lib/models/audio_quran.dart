class AudioQuran {
  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  String? revelationType;
  String? audio;
  List<Ayahs>? ayahs;

  AudioQuran(
      {this.number,
        this.name,
        this.englishName,
        this.englishNameTranslation,
        this.revelationType,
        this.audio,
        this.ayahs});

  AudioQuran.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    revelationType = json['revelationType'];
    if (json['ayahs'] != null) {
      ayahs = <Ayahs>[];
      json['ayahs'].forEach((v) {
        ayahs!.add(Ayahs.fromJson(v));
      });
    }
  }
}

class Ayahs {
  int? number;
  String? audio;
  String? text;
  String? arabic;
  int? numberInSurah;
  // int? juz;
  // int? manzil;
  // int? page;
  // int? ruku;
  // int? hizbQuarter;
  // bool? sajda;

  Ayahs(
      {this.number,
        this.audio,
        this.text,
        this.arabic,
        this.numberInSurah,
        // this.juz,
        // this.manzil,
        // this.page,
        // this.ruku,
        // this.hizbQuarter,
        // this.sajda
      });

  Ayahs.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    audio = json['audio'];
    text = json['text'];
    arabic = null;
    numberInSurah = json['numberInSurah'];
    // juz = json['juz'];
    // manzil = json['manzil'];
    // page = json['page'];
    // ruku = json['ruku'];
    // hizbQuarter = json['hizbQuarter'];
    // sajda = json['sajda'];
  }
}