import 'package:al_quran_audio/models/ayat.dart';

abstract class AyatState {}

class InitialAyatState extends AyatState {}

class LoadingAyatState extends AyatState {}

class LoadedAyatState extends AyatState {
  final List<Ayat> ayats;

  LoadedAyatState({required this.ayats});
}

class ErrorAyatState extends AyatState {
  final String message;
  ErrorAyatState({required this.message});
}
