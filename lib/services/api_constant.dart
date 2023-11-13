enum Edition { bangla, english }

class APIConstant {
  static const baseUrl = 'http://api.alquran.cloud/v1';
  static const audioBaseUrl =
      'https://cdn.islamic.network/quran/audio-surah/128/ar.alafasy';

  static const getAllSurah = '/surah';

  static const bnEdition = 'bn.bengali';
  static const enEdition = 'en.asad';

  static String getSurahUrl(
      {required String surahNumber, required Edition language}) {
    switch (language) {
      case Edition.bangla:
        return '$baseUrl/surah/$surahNumber/$bnEdition';
      case Edition.english:
        return '$baseUrl/surah/$surahNumber/$enEdition';
    }
  }

  static String getArabicSurahUrl({required String surahNumber}) {
    return '$baseUrl/surah/$surahNumber';
  }
}
