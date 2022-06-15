import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatApiProvider {
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> getMessages() async {
    final prefs = await FirebaseFirestore.instance.collection('Chat').doc(user?.uid);
  }
}