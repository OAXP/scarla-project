import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'firebase_user_provider.freezed.dart';

@freezed
abstract class ScarlaFirebaseUser implements _$ScarlaFirebaseUser {
  factory ScarlaFirebaseUser.user(User user) = _User;
  factory ScarlaFirebaseUser.loggedOut() = _LoggedOut;
  factory ScarlaFirebaseUser.initial() = _Initial;
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
