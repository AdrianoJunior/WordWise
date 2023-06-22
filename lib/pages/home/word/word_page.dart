import 'package:dictionary/pages/home/favoritos/favoritos_service.dart';
import 'package:dictionary/pages/home/history/history_service.dart';
import 'package:dictionary/pages/home/word/word.dart';
import 'package:dictionary/pages/home/word/word_api.dart';
import 'package:dictionary/utils/database/database_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class WordPage extends StatefulWidget {
  final String wordString;

  WordPage({required this.wordString});

  @override
  _WordPageState createState() => _WordPageState();
}

class _WordPageState extends State<WordPage> {
  final _api = WordApi();
  bool _isFavorite = false;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  final _favoritesService = FavoritosService();
  final _historyService = HistoryService();
  final dbHelper = DatabaseHelper();
  Word? word;

  FlutterTts flutterTts = FlutterTts();



  @override
  void initState() {
    super.initState();
    fetchData();

    _checkIsFavorite(widget.wordString, uid);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wordString),
        actions: [
          IconButton(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : Colors.black),
            onPressed: () => _onClickFavorite(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 16,
          onPressed: _speak,
          child: const Icon(Icons.play_arrow)),
      body: _body(),
    );
  }

  _body() {
    return FutureBuilder<Word?>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          final word = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            'Definition(s):',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: word.definitions?.length ?? 0,
                          itemBuilder: (context, index) {
                            final definition = word.definitions?[index];
                            return ListTile(
                              title: Text(definition != null
                                  ? '${index + 1} - $definition.'
                                  : ''),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            'Pronunciation(s):',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: word.pronunciation?.length ?? 0,
                          itemBuilder: (context, idx) {
                            final definition = word.pronunciation?[idx];
                            return ListTile(
                              title: Text(definition != null
                                  ? '${idx + 1} - $definition.'
                                  : ''),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          // if(snapshot.error.toString())
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Sorry, an unexpected error occurred while fetching the data for the word ${widget.wordString}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }


  // Busca os dados da palavra no cache
  // caso não encontre, busca na API
  Future<Word?> fetchData() async {
    final cachedData = await dbHelper.getWordCache(widget.wordString);
    dbHelper.addWordToHistory(widget.wordString);
    if (cachedData != null) {
      print(cachedData);
      word = Word.fromJson(cachedData);
      _historyService.saveWordToHistory(word!, uid);
      return Word.fromJson(cachedData);
    } else {
      final wordData = await _api.fetchWordDetails(widget.wordString);
      dbHelper.saveWordCache(widget.wordString, wordData.toJson());
      word = wordData;
      _historyService.saveWordToHistory(word!, uid);
      return wordData;
    }
  }

  // Verifica se a palavra está na lista de favoritos e atualiza o ícone do botão de favoritar
  _checkIsFavorite(String word, String uid) async {
    _isFavorite =
    await _favoritesService.isFavorite(word: word, uid: uid).then((value) {
      setState(() {});
      return value;
    });
  }


  // Favorita ou exclui a palavra dos favoritos
  _onClickFavorite() async {
    if (_isFavorite) {
      _favoritesService.deleteWordFromFavorites(uid, widget.wordString);
      setState(() {
        _isFavorite = !_isFavorite;
      });
    } else {
      _favoritesService.saveWordToFavorites(word!, uid);
      setState(() {
        _isFavorite = !_isFavorite;
      });
    }
  }

  // Reproduz a palavra selecionada em áudio (se a palavra existir na API ou cache)
  _speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.65);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(word!.word!);
  }

}
