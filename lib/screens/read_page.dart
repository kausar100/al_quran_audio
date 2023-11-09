import 'package:al_quran_audio/bloc/surah/surah_bloc.dart';
import 'package:al_quran_audio/bloc/surah/surah_state.dart';
import 'package:al_quran_audio/widgets/list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Reading extends StatefulWidget {
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
                return ListWidget(surahInfo: state.listOfSurah);
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
