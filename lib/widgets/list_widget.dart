import 'package:al_quran_audio/models/surah.dart';
import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key, required this.surahInfo});

  final List<Surah> surahInfo;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Card(
                elevation: 2.0,
                child: ListTile(
                  leading: ClipOval(
                      child: Container(
                          height: 50,
                          width: 50,
                          color: Colors.orange,
                          child: Center(child: Text('${index + 1}')))),
                  title: Text('${surahInfo[index].englishName}'),
                  subtitle: Text('${surahInfo[index].englishNameTranslation}'),
                  trailing: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey),
                    height: 50,
                    width: 50,
                    child: Center(
                        child: Text('${surahInfo[index].numberOfAyahs}')),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: surahInfo.length);
  }
}
