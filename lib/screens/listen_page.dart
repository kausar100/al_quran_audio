import 'package:al_quran_audio/bloc/surah/surah_bloc.dart';
import 'package:al_quran_audio/bloc/surah/surah_state.dart';
import 'package:al_quran_audio/widgets/list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Listening extends StatefulWidget {
  static const routeListening = '/listening_page';
  const Listening({super.key});

  @override
  State<Listening> createState() => _ListeningState();
}

class _ListeningState extends State<Listening> {

  @override
  Widget build(BuildContext context) {
    final surahBloc = BlocProvider.of<SurahBloc>(context, listen: true);
    return Scaffold(
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
                    surahInfo: state.listOfSurah,
                    onTap: (id) {
                      // print(id.toString());
                    });
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
