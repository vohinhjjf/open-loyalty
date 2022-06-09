import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_loyalty/constant.dart';

class MessageProvider {
  final FirebaseFirestore firebaseFirestore;

  MessageProvider({required this.firebaseFirestore});

  Future<void> updateDataFirestore(
      String collectionPath, String path, Map<String, String> dataNeedUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path)
        .update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getStreamFireStore(
      String pathCollection, int limit, String? textSearch) {
    if (textSearch?.isNotEmpty == true) {
      return FirebaseFirestore.instance
          .collection(pathCollection)
          .limit(limit)
          .where(FirestoreConstants.name, isEqualTo: textSearch)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(pathCollection)
          .limit(limit)
          .snapshots();
    }
  }
}
