import 'package:al_quran_audio/bloc/surah/surah_state.dart';
import 'package:al_quran_audio/db/database.dart';
import 'package:al_quran_audio/db/surah_entity.dart';
import 'package:al_quran_audio/models/surah.dart';
import 'package:al_quran_audio/repos/surah_repo.dart';
import 'package:al_quran_audio/utils/extension_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

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
        storeToDB(surah);
      }
    } catch (e) {
      emit(ErrorSurahState(message: e.toString()));
    }
  }

  storeToDB(List<Surah> surahInfo) async {
    final db =
        await $FloorAppDatabase.databaseBuilder('surah_database.db').build();
    final surahDao = db.surahDao;

    List<SurahEntity> entities = [];
    for (Surah info in surahInfo) {
      //convert to surah entity
      final entity = info.toSurahEntity();
      entities.add(entity);
    }
    await surahDao.insertSurahInfo(entities);
    if (kDebugMode) {
      print('data is saved successfully!');
    }
  }
}
