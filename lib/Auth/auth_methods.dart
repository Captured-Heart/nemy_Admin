// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class Users {
  String userId;

  Users({required this.userId});
}

class AuthMethods {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

//USER FROM FIREBASE
  Users _userFromFirebase(User user) {
    // return user != null ? Users(userId: user.uid) : null;
    return Users(userId: user.uid);
  }

  // GET UID
  Future<String> getCurrentUID() async {
    // return (await _auth.currentUser()).uid;
    return _auth.currentUser!.uid;
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return _auth.currentUser!;
  }

//SIGN IN WITH EMAIL AND PASSWORD
  Future signInWithEmailAndPassword(String? email, String password) async {
    try {
      
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email!, password: password);
      User? firebaseUser = result.user;
      if (firebaseUser!.emailVerified) return firebaseUser.uid;

      return _userFromFirebase(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

//SIGNUP WITH EMAIL AND PASSWORD
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      // await DataBaseService(uid: firebaseUser.uid).updateUserDetails(name, email, phone, address, gender, dob);
      await firebaseUser!.sendEmailVerification();
      return _userFromFirebase(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

//RESET PASSWORD
  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

//SIGN OUT
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
