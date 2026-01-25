import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  User? get currentUser;
  Future<User?> loginWithEmailAndPassword(String email, String password);
  Future<User?> signupWithEmailAndPassword(String email, String password);
  Future<void> logout();
  Future<void> sendResetPasswordEmail(String email);
}

class AuthServicesImp implements AuthServices {
  final firebaseAuth = FirebaseAuth.instance;
  @override
  User? get currentUser => firebaseAuth.currentUser;
  @override
  Future<void> sendResetPasswordEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<User?> signupWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
