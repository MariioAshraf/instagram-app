import 'package:firebase_auth/firebase_auth.dart';

class Failure {
  final String message;

  const Failure(this.message);
}

class FirebaseAuthFailure extends Failure {
  FirebaseAuthFailure(super.message);

  factory FirebaseAuthFailure.fromFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return FirebaseAuthFailure('The password provided is too weak.');
      case 'invalid-credential':
        return FirebaseAuthFailure('invalid credential.');
      case 'email-already-in-use':
        return FirebaseAuthFailure('email already in use.');
      case 'wrong-password':
        return FirebaseAuthFailure('Wrong password provided.');
      case 'user-not-found':
        return FirebaseAuthFailure('user not found.');
      default:
        return FirebaseAuthFailure('Authentication error.');
    }
  }
}
