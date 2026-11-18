import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  // 1. Singleton Pattern yang benar menggunakan 'static final'
  static final AuthServices _instance = AuthServices._internal();

  AuthServices._internal();

  factory AuthServices() {
    return _instance;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Status Auth
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign Up
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print('Error Sign UP: $e');
      return null;
    }
  }

  // Sign In (Diperbaiki: menggunakan signInWithEmailAndPassword, bukan createUser...)
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print('Error Sign In: $e');
      return null;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}