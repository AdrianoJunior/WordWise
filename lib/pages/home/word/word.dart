class Word {
  String? word;
  List<String>? definitions;
  List<String>? pronunciation;

  Word({
    this.word,
    this.definitions,
    this.pronunciation,
  });

  Word.fromJson(Map<String, dynamic> json) {
    word = json['word'];

    if (json['results'] != null) {
      definitions = <String>[];
      final results = json['results'] as List<dynamic>;
      results.forEach((result) {
        if (result is String) {
          definitions!.add(result);
        } else if (result is Map<String, dynamic>) {
          final definition = result['definition'] as String?;
          if (definition != null) {
            definitions!.add(definition);
          }
        }
      });
    }
    if (json['pronunciation'] != null) {
      if (json['pronunciation'] is String) {
        pronunciation = [json['pronunciation']];
      } else if (json['pronunciation'] is Map<String, dynamic>) {
        final pronunciationMap = json['pronunciation'] as Map<String, dynamic>;
        pronunciation = pronunciationMap.values.cast<String>().toList();
      } else if (json['pronunciation'] is List<dynamic>) {
        pronunciation = json['pronunciation'].cast<String>();
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['word'] = word;
    data['results'] = definitions;
    data['pronunciation'] = pronunciation;
    return data;
  }
}