import 'package:al_quran_audio/bloc/surah/surah_bloc.dart';
import 'package:al_quran_audio/screens/read_page.dart';
import 'package:al_quran_audio/screens/listen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatefulWidget {
  static const routeHomePage = '/home_page';
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  int _selectedIndex = 0;
  bool needToFetch = true;

  static const List<Widget> _widgetOptions = <Widget>[Reading(), Listening()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SurahBloc>(context);
    if(needToFetch){
      needToFetch = false;
      _getSurahInformation(bloc);
    }
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text('Are you sure you want to exit?'),
                actions: [
                  TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            }
        );
        return value == true;
      },
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'Read',
              backgroundColor: Colors.orange
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.headphones),
              label: 'Listen',
              backgroundColor: Colors.blue,

            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green.shade900,
          selectedFontSize: 16,
          unselectedFontSize: 12,


          onTap: _onItemTapped,
        ),
      ),
    );
  }

  _getSurahInformation(SurahBloc bloc) {
    bloc.getSurahInfo();
  }
}
