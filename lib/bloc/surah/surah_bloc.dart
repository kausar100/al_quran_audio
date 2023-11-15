import 'package:al_quran_audio/bloc/surah/surah_state.dart';
import 'package:al_quran_audio/repos/surah_repo.dart';
import 'package:bloc/bloc.dart';

class SurahBloc extends Cubit<SurahState> {
  final apiRepo = APIRepository();

  SurahBloc() : super(InitialSurahState());

  getSurahInfo() async {
    emit(LoadingSurahState());
    try {
      final surah = await apiRepo.getAllSurah();
      if (surah == null) {
        emit(
            ErrorSurahState(message: 'Error occurred during fetching data...'));
      } else {
        emit(LoadedSurahState(listOfSurah: surah));
      }
    } catch (e) {
      emit(ErrorSurahState(message: e.toString()));
    }
  }
}
