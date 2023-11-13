import 'package:al_quran_audio/bloc/surah/ayat_bloc.dart';
import 'package:al_quran_audio/bloc/surah/ayat_state.dart';
import 'package:al_quran_audio/models/ayat.dart';
import 'package:al_quran_audio/models/surah_info.dart';
import 'package:al_quran_audio/services/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadSurah extends StatefulWidget {
  static const routeReadSurah = '/read_surah_page';
  const ReadSurah({super.key});

  @override
  State<ReadSurah> createState() => _ReadSurahState();
}

class _ReadSurahState extends State<ReadSurah> {
  final AyatBloc _ayatBloc = AyatBloc();
  bool hit = false;

  _fetchData(int surahNumber, Edition language) {
    _ayatBloc.getSingleSurah(surahNumber, language);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SurahInfo;
    if (!hit) {
      hit = false;
      _fetchData(args.surah.number!, args.translationLanguage);
    }

    const String bismillahArabic = "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَـٰنِ ٱلرَّحِیمِ";
    const String bismillahBangla =
        "শুরু করছি আল্লাহর নামে যিনি পরম করুণাময়, অতি দয়ালু।";

    return Scaffold(
      appBar: AppBar(title: Text(args.surah.englishName.toString())),
      body: Center(
        child: BlocBuilder(
            bloc: _ayatBloc,
            builder: (context, state) {
              if (state is LoadingAyatState || state is InitialAyatState) {
                return const CircularProgressIndicator();
              }
              if (state is LoadedAyatState) {
                return SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: [
                      (args.surah.number! != 1 && args.surah.number != 9)
                          ?
                          //surah fatiha && surah touba
                          //attach bismillah
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Card(
                                elevation: 2.0,
                                child: ListTile(
                                  title: Text(bismillahArabic,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 2.0),
                                  subtitle: Text(bismillahBangla,
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: args.surah.numberOfAyahs,
                          itemBuilder: (context, index) {
                            final ayat = state.ayats.elementAt(index);
                            final ayatArabic =
                                state.ayatsArabic.elementAt(index);
                            return ShowAyat(ayat: ayat, ayatArabic: ayatArabic);
                          })
                    ],
                  ),
                );
              }
              if (state is ErrorAyatState) {
                return Text(state.message);
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }
}

class ShowAyat extends StatelessWidget {
  const ShowAyat({super.key, required this.ayat, required this.ayatArabic});

  final Ayat ayat;
  final Ayat ayatArabic;

  ayatWithNumber(String msg) {
    return '(${ayat.numberInSurah}) $msg';
  }

  dropNewLine(String msg) {
    return msg.substring(0, msg.length - 1);
  }

  getAyat() {
    if (ayatArabic.numberInSurah == 1 &&
        ayatArabic.number != 1 &&
        ayatArabic.number != 1236) {
      //need to fetch removing bismillah
      if (ayatArabic.text != null) {
        final msg = ayatArabic.text!.substring(40, ayatArabic.text!.length - 1);
        return dropNewLine(msg);
      }
    } else {
      return dropNewLine(ayatArabic.text!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Card(
          elevation: 2.0,
          child: ListTile(
            trailing: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green.shade100,
                    ),
                    shape: BoxShape.circle),
                child: Text(ayat.numberInSurah.toString())),
            title:
                Text(getAyat(), textAlign: TextAlign.end, textScaleFactor: 2.0),
            subtitle: Text('(${ayat.numberInSurah}) ${ayat.text}',
                textAlign: TextAlign.justify),
          ),
        ),
      ),
    );
  }
}
