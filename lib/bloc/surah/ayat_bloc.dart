import 'package:al_quran_audio/bloc/surah/ayat_state.dart';
import 'package:al_quran_audio/repos/surah_repo.dart';
import 'package:al_quran_audio/services/api_constant.dart';
import 'package:bloc/bloc.dart';

class AyatBloc extends Cubit<AyatState> {
  final apiRepo = APIRepository();

  AyatBloc() : super(InitialAyatState());

  getSingleSurah(int surahNumber, Edition language) async {
    emit(LoadingAyatState());
    try {
      final ayats = await apiRepo.getSurahByNumber(surahNumber, language);
      if (ayats == null) {
        emit(ErrorAyatState(message: 'Error occurred during fetching data...'));
      } else {
        if(ayats[0].arabic==null){
          print('arabic data error');
        }else{
          emit(LoadedAyatState(ayats: ayats));
        }
      }
    } catch (e) {
      emit(ErrorAyatState(message: e.toString()));
    }
  }
}
