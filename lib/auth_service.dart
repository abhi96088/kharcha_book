import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  // create an instance for firebaseAuth. provide access to firebase's authentication methods
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// -------------------->  function to handle signup <--------------------///
  Future<User?> signUp(String email, String password) async{

    try{
      // call firebase's method to create a user. returns a UserCredential object upon successful account creation
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      // return the user object from the UserCredential.
      return userCredential.user;
    }catch(e){
      // print the error message to the console
      print(e.toString());
      return null;  // return null if signup fails.
    }

  }

  /// -------------------->  function to handle login <--------------------///
  Future<User?> logIn(String email, String password) async{

    try{
      // call firebase's method to sign in the user. returns UserCredential object upon successful login
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      // return user object from the UserCredential
      return userCredential.user;
    }catch(e){
      // print the error message to the console.
      print(e.toString());
      return null;  // return null if login fails
    }

  }

  /// -------------------->  function to handle logout <--------------------///
  Future<void> logOut() async{
    // call firebase's signOut method to logout the user from their session
    await _auth.signOut();
  }

}