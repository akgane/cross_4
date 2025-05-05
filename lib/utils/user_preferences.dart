import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserPreferences {
  Future<void> saveUserPreferences(String theme, String language) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    await FirebaseFirestore.instance
        .collection('user-preferences')
        .doc(userId)
        .set({'theme': theme, 'language': language}, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> getUserPreferences() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return null;

    final doc =
        await FirebaseFirestore.instance
            .collection('user-preferences')
            .doc(userId)
            .get();

    return doc.data();
  }
}
