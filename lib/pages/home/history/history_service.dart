import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary/pages/home/word/word.dart';

class HistoryService {

  // Salva a palavra selecionada no histórico
  void saveWordToHistory(Word word, String uid) async {
    final collection = FirebaseFirestore.instance.collection('users');
    final document = collection.doc(uid).collection('history').doc(word.word);

    final docSnapshot = await document.get();
    if(!docSnapshot.exists) {
      document.set(word.toJson());
      document.update({
        'accessed': FieldValue.serverTimestamp(),
      });
    } else {
      document.update({
      'accessed': FieldValue.serverTimestamp(),
    });
    }
  }
}