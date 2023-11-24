import 'package:al_quran_audio/bloc/surah/surah_bloc.dart';
import 'package:al_quran_audio/bloc/surah/surah_state.dart';
import 'package:al_quran_audio/models/audio_quran.dart';
import 'package:al_quran_audio/widgets/list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
                      final surah = state.fullQuran.elementAt(id);
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  ShowSurahDetails(surah: surah)));
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

class ShowSurahDetails extends StatefulWidget {
  const ShowSurahDetails({super.key, required this.surah});

  final AudioQuran surah;

  @override
  State<ShowSurahDetails> createState() => _ShowSurahDetailsState();
}

class _ShowSurahDetailsState extends State<ShowSurahDetails> {
  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..loadRequest(Uri.parse(widget.surah.audio.toString()));
    super.initState();
  }

  @override
  void dispose() {
    controller.clearCache();
    controller.clearLocalStorage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ayats = widget.surah.ayahs!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          title: Text(widget.surah.englishName.toString()), centerTitle: true),
      body: widget.surah.audio == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                children: [
                  SizedBox(
                      height: 220,
                      width: double.infinity,
                      child: WebViewWidget(
                        controller: controller,
                      )),
                  Divider(
                      thickness: 16.0,
                      color: Colors.green.shade300,
                      height: 16.0),
                  Expanded(
                    child: ListView.builder(
                        itemCount: ayats.length,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.green.shade100,
                                child: ListTile(
                                  trailing: CircleAvatar(
                                      backgroundColor: Colors.green.shade300,
                                      foregroundColor: Colors.white,
                                      child: Text(
                                        ayats[index].numberInSurah.toString(),
                                        textScaleFactor: 1,
                                      )),
                                  title: Text(
                                    ayats[index].arabic.toString(),
                                    textDirection: TextDirection.rtl,
                                    textScaleFactor: 2,
                                  ),
                                ),
                              ),
                            )),
                  ),
                ],
              ),
            ),
    );
  }
}
