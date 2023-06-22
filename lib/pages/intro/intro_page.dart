import 'package:dictionary/pages/login/login_page.dart';
import 'package:dictionary/utils/nav.dart';
import 'package:dictionary/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatefulWidget {
  final Map<String, dynamic> jsonData;

  IntroPage({required this.jsonData});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  Map<String, dynamic> get jsonData => widget.jsonData;
  bool showDone = false;

  storeWordsList(Map<String, dynamic> jsonList) async {


    // Lê a lista de palavras do arquivo json
    List<String> words = jsonList.keys.toList();

    // Salva as palavras em uma lista de Strings
    var prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('words', words).then((value) {
      setState(() {
        showDone = value;
      });
    }).onError((error, stackTrace) {
      print('Erro na lista >>> $error');
    });
  }

  @override
  void initState() {
    super.initState();
    storeWordsList(jsonData);
  }

  final _introKey = GlobalKey<IntroductionScreenState>();

  final pageModels = [
    PageViewModel(
      title: 'WordWise',
      bodyWidget: const Text(
          'Explore an extensive collection of English words and their definitions with ease. '
          'WordWise serves as your digital dictionary, providing a comprehensive list of words and their meanings at your fingertips.'),
      image: Image.asset('assets/images/list.png'),
    ),
    PageViewModel(
      title: 'Word Favorites',
      bodyWidget: const Text(
          'Personalize your vocabulary journey by liking and favoriting words that'
          ' captivate you. With Word Favorites, you can curate a collection of your preferred words, ensuring easy access to their'
          ' definitions and enhancing your language learning experience.'),
      image: Image.asset('assets/images/favorite.png'),
    ),
    PageViewModel(
      title: 'Word History',
      bodyWidget: const Text(
          'Never lose track of the words you\'ve encountered. Word History keeps a record of all the words you\'ve explored, '
          'enabling you to revisit and review your past discoveries effortlessly. Dive into your word exploration journey'
          ' with ease and trace your progress over time.'),
      image: Image.asset('assets/images/history.png'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: _introKey,
      pages: pageModels,
      showNextButton: true,
      showSkipButton: false,
      showDoneButton: showDone,
      onDone: () {
        Prefs.setBool('firstOpen', false);
        push(context, LoginPage(), replace: true);
      },
      next: const Text("Next"),
      done: const Text("Done"),
    );
  }
}
