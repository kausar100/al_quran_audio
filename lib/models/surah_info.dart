import 'package:al_quran_audio/models/audio_quran.dart';
import 'package:al_quran_audio/models/surah.dart';
import 'package:al_quran_audio/services/api_constant.dart';

class SurahInfo {
  final Edition translationLanguage;
  final AudioQuran info;

  SurahInfo({required this.translationLanguage, required this.info});
}
