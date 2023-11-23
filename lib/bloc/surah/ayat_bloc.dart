import 'package:al_quran_audio/bloc/surah/ayat_state.dart';
import 'package:al_quran_audio/models/audio_quran.dart';
import 'package:al_quran_audio/repos/surah_repo.dart';
import 'package:al_quran_audio/services/api_constant.dart';
import 'package:bloc/bloc.dart';

class AyatBloc extends Cubit<AyatState> {
  final apiRepo = APIRepository();

  AyatBloc() : super(InitialAyatState());

  getSingleSurah(AudioQuran info) async {
    emit(LoadingAyatState());
    try {
      final ayatsWithEdition = await apiRepo.getSurahByNumber(
          info.number!, Edition.bangla);
      if (ayatsWithEdition == null) {
        emit(ErrorAyatState(message: 'Error occurred during fetching data...'));
      } else {
        //merged with infoList and return back
        List<Ayahs> ayats = _combineList(info.ayahs!, ayatsWithEdition);
        emit(LoadedAyatState(ayats: ayats));
      }
    } catch (e) {
      emit(ErrorAyatState(message: e.toString()));
    }
  }

  _combineList(List<Ayahs> arabic, List<Ayahs> translation) {
    List<Ayahs> newList = [];
    for (int i = 0; i < arabic.length; i++) {
      final withTranslation = Ayahs(number: arabic[i].number,
          numberInSurah: arabic[i].numberInSurah,
          arabic: arabic[i].text,
          text: translation[i].text,
          audio: arabic[i].audio);

      newList.add(withTranslation);
    }

    return newList;
  }
}