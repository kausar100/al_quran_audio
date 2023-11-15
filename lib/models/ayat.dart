class Ayat {
  int? number;
  String? text;
  String? arabic;
  int? numberInSurah;
  int? juz;
  int? manzil;
  int? page;
  int? ruku;
  int? hizbQuarter;
  // bool? sajda;

  Ayat({
    this.number,
    this.text,
    this.arabic,
    this.numberInSurah,
    this.juz,
    this.manzil,
    this.page,
    this.ruku,
    this.hizbQuarter,
    // this.sajda
  });

  Ayat.fromJson(Map<String, dynamic> json) {
    number = json.containsKey('number') ? json['number'] : null;
    text = json.containsKey('text') ? json['text'] : null;
    arabic = null;
    numberInSurah =
        json.containsKey('numberInSurah') ? json['numberInSurah'] : null;
    juz = json.containsKey('juz') ? json['juz'] : null;
    manzil = json.containsKey('manzil') ? json['manzil'] : null;
    page = json.containsKey('page') ? json['page'] : null;
    ruku = json.containsKey('marukunzil') ? json['ruku'] : null;
    hizbQuarter = json.containsKey('hizbQuarter') ? json['hizbQuarter'] : null;
    // sajda = json.containsKey('sajda') ? json['sajda'] : null;
  }
}
