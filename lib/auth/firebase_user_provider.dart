import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

enum LoginStatus {
  user,
  loggedOut,
  initial,
}

class ScarlaFirebaseUser {
  ScarlaFirebaseUser({this.firebaseUser, this.loginStatus});
  final User firebaseUser;
  final LoginStatus loginStatus;

  static ScarlaFirebaseUser user(User user) =>
      ScarlaFirebaseUser(firebaseUser: user, loginStatus: LoginStatus.user);

  static ScarlaFirebaseUser loggedOut() =>
      ScarlaFirebaseUser(loginStatus: LoginStatus.loggedOut);

  static ScarlaFirebaseUser initial() =>
      ScarlaFirebaseUser(loginStatus: LoginStatus.initial);

  T when<T>(
      {T Function(User) user, T Function() loggedOut, T Function() initial}) {
    switch (loginStatus) {
      case LoginStatus.user:
        return user(firebaseUser);
      case LoginStatus.loggedOut:
        return loggedOut();
      default:
        return initial();
    }
  }

  T maybeWhen<T>(
      {T Function(User) user,
      T Function() loggedOut,
      T Function() initial,
      T Function() orElse}) {
    switch (loginStatus) {
      case LoginStatus.user:
        return user != null ? user(firebaseUser) : orElse();
      case LoginStatus.loggedOut:
        return loggedOut != null ? loggedOut() : orElse();
      case LoginStatus.initial:
        return initial != null ? initial() : orElse();
      default:
        return orElse();
    }
  }
}

bool loggedIn = false;

final scarlaFirebaseUser = FirebaseAuth.instance
    .userChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<ScarlaFirebaseUser>((user) {
  loggedIn = user != null;
  return user != null
      ? ScarlaFirebaseUser.user(user)
      : ScarlaFirebaseUser.loggedOut();
}).shareValueSeeded(ScarlaFirebaseUser.initial());

ScarlaFirebaseUser get currentUser => scarlaFirebaseUser.value;
