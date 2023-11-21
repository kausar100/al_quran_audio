import 'package:al_quran_audio/bloc/surah/ayat_bloc.dart';
import 'package:al_quran_audio/bloc/surah/surah_bloc.dart';
import 'package:al_quran_audio/screens/listen_page.dart';
import 'package:al_quran_audio/screens/read_page.dart';
import 'package:al_quran_audio/screens/read_surah_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SurahBloc()),
        BlocProvider(create: (_) => AyatBloc()),
      ],

      child: MaterialApp(
          title: 'Al Quran Audio',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green
          ),
          home: const AppView(),
          routes: {
            AppView.routeHomePage: (context) => const AppView(),
            Reading.routeReading: (context) => const Reading(),
            Listening.routeListening: (context) => const Listening(),
            ReadSurah.routeReadSurah: (context) => const ReadSurah()
          }),
    );
  }
}
