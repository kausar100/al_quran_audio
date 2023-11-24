import 'package:al_quran_audio/bloc/surah/surah_bloc.dart';
import 'package:al_quran_audio/bloc/surah/surah_state.dart';
import 'package:al_quran_audio/models/audio_quran.dart';
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
  _gotoReadPage(int surahNumber, AudioQuran quran) {
    Navigator.pushNamed(context, ReadSurah.routeReadSurah,
        arguments:
            SurahInfo(translationLanguage: Edition.bangla, info: quran));
  }

  @override
  Widget build(BuildContext context) {
    final surahBloc = BlocProvider.of<SurahBloc>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: BlocConsumer<SurahBloc, SurahState>(
            bloc: surahBloc,
            listener: (context, state) {
              if (state is SavedSurahState) {
                _showSnackBar(state.message);
              }
            },
            builder: (context, state) {
              if (state is LoadingSurahState || state is InitialSurahState) {
                return const CircularProgressIndicator();
              }
              if (state is LoadedSurahState) {
                return ListWidget(
                  surahInfo: state.fullQuran,
                  onTap: (id) {
                    // print('surah number : ${id + 1}');
                    _gotoReadPage(id, state.fullQuran.elementAt(id));
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

  _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
