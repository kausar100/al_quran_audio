import 'package:al_quran_audio/models/audio_quran.dart';
import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key, required this.surahInfo, required this.onTap});

  final List<AudioQuran> surahInfo;
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
                  leading: CircleAvatar(
                      backgroundColor: Colors.green.shade400,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      )),
                  title: Text('${surahInfo[index].englishName}'),
                  subtitle: Text('${surahInfo[index].englishNameTranslation}'),
                  trailing: CircleAvatar(
                      backgroundColor: Colors.green.shade50,
                      child: Text('${surahInfo[index].ayahs!.length}')),
                ),
              ),
            ),
          );
        },
        itemCount: surahInfo.length);
  }
}
