import 'package:dictionary/utils/prefs.dart';
import 'package:dictionary/utils/simple_bloc.dart';

class WordsBloc extends SimpleBloc<List<String>> {
  List<String> _words = [];
  List<String> _filteredWords = [];


  Future<List<String>> fetch({String? searchTerm}) async {
    try {
      _words = await Prefs.getStringList('words');
      _filteredWords = _words;

      add(_filteredWords);


      return _filteredWords;

    } catch (e) {
      addError(e);
      return [];
    }
  }

  void filterWords(String searchTerm) {
    if (searchTerm.isEmpty) {
      _filteredWords = _words;
    } else {
      _filteredWords = _words
          .where((word) => word.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }
    add(_filteredWords);
  }
}