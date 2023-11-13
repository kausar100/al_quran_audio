import 'dart:convert';

import 'package:al_quran_audio/models/ayat.dart';
import 'package:al_quran_audio/models/surah.dart';
import 'package:al_quran_audio/services/api_call.dart';
import 'package:al_quran_audio/services/api_constant.dart';

class APIRepository {
  final apiCall = APICall();

  Future<List<Surah>?> getAllSurah() async {
    try {
      final response = await apiCall.getSurahNames();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;

        return data.map((s) => Surah.fromJson(s)).toList();
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }

  Future<List<Ayat>?> getSurahByNumber(int number, Edition language) async {
    try {
      final response = await apiCall.getSurahById(number, language);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data']['ayahs'] as List;

        return data.map((s) => Ayat.fromJson(s)).toList();
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }

  Future<List<Ayat>?> getArabicSurahByNumber(int number) async {
    try {
      final response = await apiCall.getArabicSurahById(number);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data']['ayahs'] as List;

        return data.map((s) => Ayat.fromJson(s)).toList();
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }
}
