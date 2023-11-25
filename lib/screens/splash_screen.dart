import 'package:al_quran_audio/bloc/surah/surah_bloc.dart';
import 'package:al_quran_audio/bloc/surah/surah_state.dart';
import 'package:al_quran_audio/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  static const routeSplashScreen = '/splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool needToFetch = true;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SurahBloc>(context, listen: true);

    if (needToFetch) {
      needToFetch = false;
      _getSurahInformation(bloc);
    }
    return Scaffold(
      body: Center(
        child: BlocConsumer<SurahBloc, SurahState>(
            bloc: bloc,
            listener: (context, state) {
              if (state is LoadedSurahState) {
                //go to home page
                Navigator.pushReplacementNamed(context, MainPage.routeHomePage);
              }
            },
            builder: (context, state) {
              if (state is LoadingSurahState || state is InitialSurahState) {
                return Stack(
                  children: [
                    Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 32.0),
                          child: Image.asset('assets/images/app_logo.png',
                              height: 100, width: 200),
                        )),
                    Container(
                      margin: const EdgeInsets.only(bottom: 32.0),
                      alignment: Alignment.bottomCenter,
                      child: CircularProgressIndicator(
                        color: Colors.amber.shade300,
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }

  _getSurahInformation(SurahBloc bloc) {
    bloc.getSurahInfo();
  }
}
