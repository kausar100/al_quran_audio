import 'dart:convert';

import 'package:al_quran_audio/models/surah.dart';
import 'package:al_quran_audio/services/api_call.dart';

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
}
