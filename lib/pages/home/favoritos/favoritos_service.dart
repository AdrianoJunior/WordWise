import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary/pages/home/word/word.dart';


class FavoritosService {
  void saveWordToFavorites(Word word, String uid) {
    final collection = FirebaseFirestore.instance.collection('users');
    final document = collection.doc(uid).collection('favorites').doc(word.word);

    document.set(word.toJson());
  }

  void deleteWordFromFavorites(String uid, String wordId) {
    final collection = FirebaseFirestore.instance.collection('users').doc(uid).collection('favorites');
    final document = collection.doc(wordId);

    document.delete();
  }

  Future<bool> isFavorite({required String word, required String uid}) async {

    try {
      final favoritesCollection = FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('favorites');

      final doc = await favoritesCollection.doc(word).get();

      if (doc.exists) {
            return true;
          } else {
            return false;

          }
    } catch (e) {
      print(e);
      return false;
    }
  }
}