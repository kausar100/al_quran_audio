class Ayat {
  int? number;
  String? text;
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
    numberInSurah =
        json.containsKey('numberInSurah') ? json['numberInSurah'] : null;
    juz = json.containsKey('juz') ? json['juz'] : null;
    manzil = json.containsKey('manzil') ? json['manzil'] : null;
    page = json.containsKey('page') ? json['page'] : null;
    ruku = json.containsKey('marukunzil') ? json['ruku'] : null;
    hizbQuarter = json.containsKey('hizbQuarter') ? json['hizbQuarter'] : null;
    // sajda = json.containsKey('sajda') ? json['sajda'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['number'] = number;
    data['text'] = text;
    data['numberInSurah'] = numberInSurah;
    data['juz'] = juz;
    data['manzil'] = manzil;
    data['page'] = page;
    data['ruku'] = ruku;
    data['hizbQuarter'] = hizbQuarter;
    // data['sajda'] = sajda;
    return data;
  }
}
