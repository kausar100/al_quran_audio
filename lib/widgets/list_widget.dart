import 'package:al_quran_audio/models/surah.dart';
import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key, required this.surahInfo, required this.onTap});

  final List<Surah> surahInfo;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Card(
                shadowColor: Colors.green.shade100,
                elevation: 1.0,
                child: ListTile(
                    onTap: () {
                      //send index
                      onTap(index);
                    },
                    leading: ClipOval(
                        child: Container(
                            height: 40,
                            width: 40,
                            color: Colors.green.shade100,
                            child: Center(child: Text('${index + 1}')))),
                    title: Text('${surahInfo[index].englishName}'),
                    subtitle:
                        Text('${surahInfo[index].englishNameTranslation}'),
                    trailing:
                    Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green.shade50,
                            ),
                            shape: BoxShape.circle),
                        child: Text('${surahInfo[index].numberOfAyahs}'))
                ),
              ),
            ),
          );
        },
        itemCount: surahInfo.length);
  }
}
