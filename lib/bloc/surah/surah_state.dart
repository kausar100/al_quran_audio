import 'package:al_quran_audio/models/surah.dart';

abstract class SurahState {}

class InitialSurahState extends SurahState {}

class LoadingSurahState extends SurahState {}

class LoadedSurahState extends SurahState {
  final List<Surah> listOfSurah;

  LoadedSurahState({required this.listOfSurah});
}

class ErrorSurahState extends SurahState {
  final String message;
  ErrorSurahState({required this.message});
}
