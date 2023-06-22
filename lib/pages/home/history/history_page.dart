import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary/pages/home/history/history_bloc.dart';
import 'package:dictionary/pages/home/word/word.dart';
import 'package:dictionary/pages/home/word/word_page.dart';
import 'package:dictionary/utils/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  static String uid = FirebaseAuth.instance.currentUser!.uid;
  final _bloc = HistoryBloc(uid: uid);

  @override
  void initState() {
    super.initState();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            final wordHistory = snapshot.data!.docs;

            return ListView.builder(
              itemCount: wordHistory.length,
              itemBuilder: (context, index) {
                final word = Word.fromJson(wordHistory[index].data() as Map<String, dynamic>);

                // Recupera o timestamp do documento no firebase
                final accessedTimestamp = wordHistory[index].get('accessed') as Timestamp?;

                // Converte o timestamp para DateTime
                final accessedDateTime = accessedTimestamp != null
                    ? convertTimestampToDateTime(accessedTimestamp)
                    : null;

                // Formata a data de acesso para o padrão brasileiro
                final formattedDateTime = accessedDateTime != null
                    ? DateFormat('dd/MM/yyyy hh:mm').format(accessedDateTime)
                    : '';

                return GestureDetector(
                  onTap: () => push(context, WordPage(wordString: word.word!)),
                  child: Card(
                    child: ListTile(
                      title: Text(word.word ?? ''),
                      subtitle: Text('Last access at: $formattedDateTime'),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Failed to fetch word history.',
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  DateTime convertTimestampToDateTime(Timestamp timestamp) {
    final dateTime = timestamp.toDate().toLocal();
    final formatter = DateFormat('dd/MM/yyyy hh:mm');
    final formattedDateTime = formatter.format(dateTime);
    return formatter.parse(formattedDateTime);
  }


}
