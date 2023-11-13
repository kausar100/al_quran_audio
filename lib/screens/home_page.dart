import 'package:al_quran_audio/screens/read_page.dart';
import 'package:al_quran_audio/screens/listen_page.dart';
import 'package:flutter/material.dart';

class AppView extends StatefulWidget {
  static const routeHomePage = '/home_page';
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[Reading(), Listening()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Read',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.headphones),
            label: 'Listen',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green.shade900,
        onTap: _onItemTapped,
      ),
    );
  }
}
