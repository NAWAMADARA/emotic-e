import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
class Auth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Private constructor for the Singleton
  Auth._privateConstructor();

  // Singleton instance
  static final Auth _instance = Auth._privateConstructor();

  factory Auth() {
    return _instance;
  }

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future <UserCredential> signInWithEmailAndPassword({required String email, required String password,
}) async {
   return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
  }
  Future <UserCredential> createUserWithEmailAndPassword({required String email, required String password,
  }) async {
   return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
  }
  Future <void> signOut() async{
    await _firebaseAuth.signOut();
  }
}
