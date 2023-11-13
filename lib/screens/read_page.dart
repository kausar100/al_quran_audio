import 'package:al_quran_audio/bloc/surah/ayat_bloc.dart';
import 'package:al_quran_audio/bloc/surah/surah_bloc.dart';
import 'package:al_quran_audio/bloc/surah/surah_state.dart';
import 'package:al_quran_audio/models/surah.dart';
import 'package:al_quran_audio/models/surah_info.dart';
import 'package:al_quran_audio/screens/read_surah_page.dart';
import 'package:al_quran_audio/services/api_constant.dart';
import 'package:al_quran_audio/widgets/list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Reading extends StatefulWidget {
  static const routeReading = '/reading_page';
  const Reading({super.key});

  @override
  State<Reading> createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  final SurahBloc _surahBloc = SurahBloc();

  @override
  void initState() {
    _surahBloc.getAllSurah();
    super.initState();
  }

  _gotoReadPage(int surahNumber, Surah surah) {
    Navigator.pushNamed(context, ReadSurah.routeReadSurah,
        arguments:
            SurahInfo(translationLanguage: Edition.bangla, surah: surah));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder(
            bloc: _surahBloc,
            builder: (context, state) {
              if (state is LoadingSurahState || state is InitialSurahState) {
                return const CircularProgressIndicator();
              }
              if (state is LoadedSurahState) {
                return ListWidget(
                  surahInfo: state.listOfSurah,
                  onTap: (id) {
                    print('surah number : ${id + 1}');
                    _gotoReadPage(id, state.listOfSurah.elementAt(id));
                  },
                );
              }
              if (state is ErrorSurahState) {
                return Text(state.message);
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }
}
