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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['name'] = name;
    data['englishName'] = englishName;
    data['englishNameTranslation'] = englishNameTranslation;
    data['revelationType'] = revelationType;
    if (ayahs != null) {
      data['ayahs'] = ayahs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ayahs {
  int? number;
  String? audio;
  String? text;
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
    numberInSurah = json['numberInSurah'];
    // juz = json['juz'];
    // manzil = json['manzil'];
    // page = json['page'];
    // ruku = json['ruku'];
    // hizbQuarter = json['hizbQuarter'];
    // sajda = json['sajda'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['audio'] = audio;
    data['text'] = text;
    data['numberInSurah'] = numberInSurah;
    // data['juz'] = this.juz;
    // data['manzil'] = this.manzil;
    // data['page'] = this.page;
    // data['ruku'] = this.ruku;
    // data['hizbQuarter'] = this.hizbQuarter;
    // data['sajda'] = this.sajda;
    return data;
  }
}