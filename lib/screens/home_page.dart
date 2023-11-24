import 'package:al_quran_audio/screens/read_page.dart';
import 'package:al_quran_audio/screens/listen_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const routeHomePage = '/home_page';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[Reading(), Listening()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            });
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
                backgroundColor: Colors.orange),
            BottomNavigationBarItem(
              icon: Icon(Icons.headphones),
              label: 'Listen',
              backgroundColor: Colors.blue,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedFontSize: 16,
          unselectedFontSize: 12,
          selectedItemColor: Colors.green,
          selectedIconTheme: const IconThemeData(size: 32),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
