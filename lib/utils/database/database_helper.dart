import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert' as convert;

class DatabaseHelper {
  Future<Database?> _initDatabase() async {
    try {
      return openDatabase(
        join(await getDatabasesPath(), 'words.db'),
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE IF NOT EXISTS word_cache (
          word TEXT PRIMARY KEY, data TEXT
          )
          ''');

          await db.execute('''
      CREATE TABLE IF NOT EXISTS word_history(
        word TEXT PRIMARY KEY,
        timestamp INTEGER
      )
    ''');
        },
        version: 1,
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> addWordToHistory(String word) async {
    Database? _db = await _initDatabase();
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    if (_db != null) {
      await _db.insert(
        'word_history',
        {
          'word': word,
          'timestamp': timestamp,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<String>> getWordHistory() async {
    Database? _db = await _initDatabase();

    if (_db != null) {
      final result = await _db.query('word_history', orderBy: 'timestamp DESC');

      return result.map<String>((row) => row['word'] as String).toList();
    }
    return [];
  }

  Future<Map<String, dynamic>?> getWordCache(String word) async {

    print('getting word froom cache');
    Database? _db = await _initDatabase();
    if (_db != null) {
      {
        final cachedData = await _db.query(
          'word_cache',
          where: 'word = ?',
          whereArgs: [word],
        );

        if (cachedData.isNotEmpty) {
          final jsonString = cachedData.first['data'] as String;
          return convert.json.decode(jsonString);
        }
      }
    }
    return null;
  }

  Future<void> saveWordCache(String word, Map<String, dynamic> wordData) async {
    final jsonString = convert.json.encode(wordData);
    Database? _db = await _initDatabase();
    if (_db != null) {
      await _db.insert(
        'word_cache',
        {
          'word': word,
          'data': jsonString,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}
