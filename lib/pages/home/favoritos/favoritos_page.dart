import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary/pages/home/favoritos/favoritos_bloc.dart';
import 'package:dictionary/pages/home/word/word_page.dart';
import 'package:dictionary/utils/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  static String uid = FirebaseAuth.instance.currentUser!.uid;
  final _bloc = FavoritesBloc(uid: uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final favorites = snapshot.data!.docs;

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: kIsWeb ? 6 : 3,
                childAspectRatio: 1.0,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final favorite = favorites[index];
                return GestureDetector(
                  onTap: () => push(context, WordPage(wordString: favorite['word'])),
                  child: Card(
                    child: Center(
                      child: Text(favorite['word']),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Failed to fetch favorites.',
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
