import 'package:al_quran_audio/bloc/surah/ayat_bloc.dart';
import 'package:al_quran_audio/bloc/surah/ayat_state.dart';
import 'package:al_quran_audio/models/audio_quran.dart';
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
  bool hit = false;

  _fetchData(AyatBloc bloc, AudioQuran info, Edition language) {
    hit = true;
    bloc.getSingleSurah(info, language);
  }

  @override
  Widget build(BuildContext context) {
    final _ayatBloc = BlocProvider.of<AyatBloc>(context, listen: true);
    final args = ModalRoute.of(context)!.settings.arguments as SurahInfo;

    if (!hit) {
      _fetchData(_ayatBloc, args.info, args.translationLanguage);
    }

    const String bismillahArabic = "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَـٰنِ ٱلرَّحِیمِ";
    const String bismillahBangla =
        "শুরু করছি আল্লাহর নামে যিনি পরম করুণাময়, অতি দয়ালু।";

    return Scaffold(
      appBar: AppBar(title: Text(args.info.englishName.toString())),
      body: Center(
        child: BlocBuilder<AyatBloc, AyatState>(
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
                      (args.info.number! != 1 && args.info.number != 9)
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
                          itemCount: state.ayats.length,
                          itemBuilder: (context, index) {
                            final ayat = state.ayats.elementAt(index);
                            return ShowAyat(ayat: ayat);
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
  const ShowAyat({super.key, required this.ayat});

  final Ayahs ayat;

  ayatWithNumber(String msg) {
    return '(${ayat.numberInSurah}) $msg';
  }

  dropNewLine(String msg) {
    return msg.substring(0, msg.length - 1);
  }

  getAyat() {
    if (ayat.numberInSurah == 1 && ayat.number != 1 && ayat.number != 1236) {
      //need to fetch removing bismillah
      if (ayat.arabic != null) {
        final msg = ayat.arabic!.substring(40, ayat.arabic!.length - 1);
        return dropNewLine(msg);
      }
    } else {
      return dropNewLine(ayat.arabic!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ayat.arabic == null
        ? const SizedBox(
            height: 16, width: 16, child: CircularProgressIndicator())
        : SizedBox(
            width: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Card(
                elevation: 2.0,
                child: ListTile(
                  trailing: CircleAvatar(
                      backgroundColor: Colors.green.shade50,
                      child: Text(ayat.numberInSurah.toString())),
                  title: Text(getAyat(),
                      textDirection: TextDirection.rtl, textScaleFactor: 2.0),
                  subtitle: Text('(${ayat.numberInSurah}) ${ayat.text}',
                      textAlign: TextAlign.justify),
                ),
              ),
            ),
          );
  }
}
