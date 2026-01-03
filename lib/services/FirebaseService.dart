import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign in anonymously and assign default role
  Future<User?> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;

      if (user != null) {
        // Store user data in Firestore with a default role
        await _firestore.collection('users').doc(user.uid).set({
          'role': 'caregiver', // Default role (change as needed)
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      return user;
    } catch (e) {
      print("Error signing in: $e");
      return null;
    }
  }

  // Get user role from Firestore
  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc['role'] as String?;
      }
    } catch (e) {
      print("Error fetching role: $e");
    }
    return null;
  }

  // Sign out user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
