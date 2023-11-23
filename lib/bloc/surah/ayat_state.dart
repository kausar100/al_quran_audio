import 'package:al_quran_audio/models/audio_quran.dart';

abstract class AyatState {}

class InitialAyatState extends AyatState {}

class LoadingAyatState extends AyatState {}

class LoadedAyatState extends AyatState {
  final List<Ayahs> ayats;

  LoadedAyatState({required this.ayats});
}

class ErrorAyatState extends AyatState {
  final String message;
  ErrorAyatState({required this.message});
}
