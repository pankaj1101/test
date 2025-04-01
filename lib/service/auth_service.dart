import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> registerUser(String email, String password) async {
    try {
      // Create user in Firebase Auth
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Get user ID
      String uid = userCredential.user!.uid;

      // Store user details in Firestore
      await _firestore.collection("users").doc(uid).set({
        "uid": uid,
        "email": email,
        "createdAt": FieldValue.serverTimestamp(),
      });

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
