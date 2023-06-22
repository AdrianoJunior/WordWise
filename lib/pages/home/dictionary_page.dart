import 'package:dictionary/pages/home/words_bloc.dart';
import 'package:dictionary/utils/nav.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'word/word_page.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  List<String>? words;
  final _bloc = WordsBloc();

  @override
  void initState() {
    super.initState();
    _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => _bloc.filterWords(value),
              decoration: const InputDecoration(
                  labelText: 'Search a word', icon: Icon(Icons.search_rounded)),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<String>>(
              stream: _bloc.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<String>? words = snapshot.data;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: kIsWeb ? 6 : 3,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    ),
                    itemCount: words?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => push(context, WordPage(wordString: words![index])),
                        child: Card(
                          child: Center(
                            child: Text(words?[index] ?? ''),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error loading the list of words');
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
