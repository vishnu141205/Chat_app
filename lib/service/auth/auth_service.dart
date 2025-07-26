import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;  

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid':userCredential.user!.uid,
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Optionally, you can save additional user data to Firestore
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid':userCredential.user!.uid,
        'email': email,
      });


      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to register: $e');
    }
  }
  Future<void> signOut() async{
    return await _auth.signOut();
  }

}
