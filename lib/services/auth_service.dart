import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  // create an instance for firebaseAuth. provide access to firebase's authentication methods
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  /// -------------------->  function to handle signup <--------------------///
  Future<User?> signUp(String email, String password, String name) async{

    try{
      // call firebase's method to create a user. returns a UserCredential object upon successful account creation
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      User? user  = userCredential.user;  // instance of user

      // store name on firebase
      if(user != null){
        await fireStore.collection('users').doc(user.uid).set({
          'name' : name,
          'email' : email
        });
      }

      // return the user object from the UserCredential.
      return user;
    }catch(e){
      // print the error message to the console
      print(e.toString());
      return null;  // return null if signup fails.
    }

  }

  /// -------------------->  function to handle login <--------------------///
  Future<Map<String, dynamic>?> logIn(String email, String password) async{

    try{
      // call firebase's method to sign in the user. returns UserCredential object upon successful login
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      User? user =  userCredential.user;

      // check if user exists
      if(user != null){
        // get user data
        DocumentSnapshot userData = await fireStore.collection('users').doc(user.uid).get();

        // check if user data exists
        if(userData.exists){
          return userData.data() as Map<String, dynamic>;   // return user data
        }
      }

      return null;  // return null if user does not exists
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