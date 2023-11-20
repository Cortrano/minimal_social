import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  final User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');

  Future<void> addPost(String message) {
    return posts.add({
      'userEmail': user!.email,
      'message': message,
      'timeStamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('timeStamp', descending: true)
        .snapshots();
    return postsStream;
  }
}
