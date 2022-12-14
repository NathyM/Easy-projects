import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class EasyProjectMobileFirebaseUser {
  EasyProjectMobileFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

EasyProjectMobileFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<EasyProjectMobileFirebaseUser> easyProjectMobileFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<EasyProjectMobileFirebaseUser>(
      (user) {
        currentUser = EasyProjectMobileFirebaseUser(user);
        return currentUser!;
      },
    );
