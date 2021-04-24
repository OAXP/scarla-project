import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ScarlaFirebaseUser {
  ScarlaFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

ScarlaFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ScarlaFirebaseUser> scarlaFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<ScarlaFirebaseUser>((user) => currentUser = ScarlaFirebaseUser(user));
