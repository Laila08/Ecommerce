import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  Future<User?> signinUser(String email, String password);
  Future<User?> signupUser(String email, String password);
  User? get currentUser;
  Stream<User?> authStateChanges();
}

class Auth implements AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<User?> signinUser(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<User?> signupUser(String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  // TODO: implement currentUser
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
}
