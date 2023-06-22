import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary/utils/simple_bloc.dart';

class FavoritesBloc extends SimpleBloc {
  String uid;


  FavoritesBloc({required this.uid});

  get _favorites => FirebaseFirestore.instance.collection("users/").doc(uid).collection('favorites').orderBy('word');

  Stream<QuerySnapshot> get stream => _favorites.snapshots();
}