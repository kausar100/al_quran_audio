import 'package:al_quran_audio/services/api_constant.dart';
import 'package:http/http.dart' as http;

class APICall {
  //get all Surah names
  Future<http.Response> getSurahNames() async {
    try {
      final uri = Uri.parse('${APIConstant.baseUrl}${APIConstant.getAllSurah}');

      return await http.get(uri);
    } catch (error) {
      rethrow;
    }
  }

  //get all Surah names
  Future<http.Response> getSurahById(int id, Edition edition) async {
    try {
      final uri = Uri.parse(APIConstant.getSurahUrl(surahNumber: id.toString(), language: edition));

      return await http.get(uri);
    } catch (error) {
      rethrow;
    }
  }
}
