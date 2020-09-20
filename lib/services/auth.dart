import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<UserModel> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Sign in Anonym
  Future signInAnonym() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register 
  Future registerUser(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in 
  Future signInUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // signOut
  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}