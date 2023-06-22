import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary/utils/simple_bloc.dart';

class HistoryBloc extends SimpleBloc {
  String uid;


  HistoryBloc({required this.uid});

  get _favorites => FirebaseFirestore.instance.collection("users/").doc(uid).collection('history').orderBy('accessed', descending: true);

  Stream<QuerySnapshot> get stream => _favorites.snapshots();
}