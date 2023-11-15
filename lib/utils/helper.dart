import 'package:al_quran_audio/models/ayat.dart';

class Helper{
  // insert editionLanguage to text, arabicLanguage to arabic
  List<Ayat> mergedAyatList(List<Ayat> et, List<Ayat> arabicEdition){
    List<Ayat> ayats = [];
    for(int id = 0; id<et.length; id++){
      final ayat = Ayat(number: et[id].number, text: et[id].text, arabic: arabicEdition[id].text, numberInSurah: et[id].numberInSurah);
      ayats.add(ayat);
    }
    // print('merging list done with length ${et.length}');
    return ayats;
  }

}

