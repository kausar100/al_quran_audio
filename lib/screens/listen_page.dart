import 'dart:convert';

import 'package:al_quran_audio/bloc/surah/surah_bloc.dart';
import 'package:al_quran_audio/bloc/surah/surah_state.dart';
import 'package:al_quran_audio/models/audio_quran.dart';
import 'package:al_quran_audio/widgets/list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class Listening extends StatefulWidget {
  static const routeListening = '/listening_page';

  const Listening({super.key});

  @override
  State<Listening> createState() => _ListeningState();
}

class _ListeningState extends State<Listening> {
  Future<List<AudioQuran>?> getFullQuran() async {
    //http://api.alquran.cloud/v1/quran/ar.alafasy
    final uri = Uri.parse("http://api.alquran.cloud/v1/quran/ar.alafasy");

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body)['data']['surahs'] as List;
        final result = body.map((e) => AudioQuran.fromJson(e)).toList();

        print(result.length.toString());
        return result;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // final surahBloc = BlocProvider.of<SurahBloc>(context, listen: true);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getFullQuran(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final fullQuran = snapshot.data!;
                return ListView.builder(
                  itemCount: fullQuran.length,
                  itemBuilder: (context, index) {
                    final surah = fullQuran[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ShowSurahDetails(surah: surah),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          color: Colors.green.shade200,
                          child: ListTile(
                            leading: CircleAvatar(
                                child: Text(surah.number.toString())),
                            title: Text(surah.englishName.toString()),
                            subtitle:
                                Text(surah.englishNameTranslation.toString()),
                            trailing: Text(surah.ayahs!.length.toString()),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.hasError) {
                return const Text(
                  'Error during fetching data...',
                  style: TextStyle(color: Colors.red),
                );
              }
            }
            return const Text('Loading please wait...');
          },
        ),
      ),
      // Center(
      //   child: BlocConsumer<SurahBloc, SurahState>(
      //       bloc: surahBloc,
      //       listener: (context, state) {
      //         if (state is SavedSurahState) {
      //           _showSnackBar(state.message);
      //         }
      //       },
      //       builder: (context, state) {
      //         if (state is LoadingSurahState || state is InitialSurahState) {
      //           return const CircularProgressIndicator();
      //         }
      //         if (state is LoadedSurahState) {
      //           return ListWidget(
      //               surahInfo: state.listOfSurah,
      //               onTap: (id) {
      //                 // print(id.toString());
      //               });
      //         }
      //         if (state is ErrorSurahState) {
      //           return Text(state.message);
      //         }
      //         return const SizedBox.shrink();
      //       }),
      // ),
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
    final uri =
        "https://cdn.islamic.network/quran/audio-surah/128/ar.alafasy/${widget.surah.number!}.mp3";
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..loadRequest(Uri.parse(uri));
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
      appBar: AppBar(
          title: Text(widget.surah.englishName.toString()), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            SizedBox(
                height: 220,
                width: double.infinity,
                child: WebViewWidget(
                  controller: controller,
                )),
            Divider(
                thickness: 16.0, color: Colors.green.shade300, height: 16.0),
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
                              ayats[index].text.toString(),
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
