import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future signup(String email, String password, String username) async {
        await auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future Signin(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  void SignOut() {
    auth.signOut();
  }
}
