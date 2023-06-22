import 'dart:convert' as convert;
import 'package:dictionary/pages/home/word/word.dart';
import 'package:http/http.dart' as http;

class WordApi {
  Future<Word> fetchWordDetails(String word) async {

    print('getting word from API');
    Map<String, String> headers = {
      "X-RapidAPI-Key": "0b85c1cb38msh91a3442a5f99598p13ef65jsn21278343e8b3",
      "X-RapidAPI-Host": "wordsapiv1.p.rapidapi.com"
    };

    var url = 'https://wordsapiv1.p.rapidapi.com/words/$word';

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final jsonData = convert.json.decode(response.body);

      print(jsonData.toString());

      final results = jsonData['results'];
      final List<String> definitions = [];
      for (final result in results) {
        final definition = result['definition'];
        definitions.add(definition);
      }

      final wordObj = Word.fromJson(jsonData);

      return wordObj;
    } else {
      throw Exception('There was an error fetching word details');
    }
  }
}
