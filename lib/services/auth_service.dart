import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kharcha_book/services/database_services.dart';

class AuthService {

  // create an instance for firebaseAuth. provide access to firebase's authentication methods
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  /// -------------------->  function to handle signup <--------------------///
  Future<User?> signUp(String email, String password, String name) async{

    try{
      // call firebase's method to create a user. returns a UserCredential object upon successful account creation
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      User? user  = userCredential.user;  // instance of user

      // store name, email and create a expense table  on firebase
      if(user != null){
        DatabaseServices().createUser(name, email, user.uid);
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
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
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

  /// -------------------->  function to handle forget password <--------------------///
  Future<String?> resetPassword(String email) async{
    try{
      auth.sendPasswordResetEmail(email: email);
        return "Email Sent Successfully";
      return null;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  /// -------------------->  function to check if user exist <--------------------///
  Future<bool> isUserExist(String email) async{
    QuerySnapshot querySnap = await fireStore.collection('users').where('email', isEqualTo: email).get();

    if(querySnap.docs.isNotEmpty){
      return true;
    }
    return false;
  }

  /// -------------------->  function to handle logout <--------------------///
  Future<void> logOut() async{
    // call firebase's signOut method to logout the user from their session
    await auth.signOut();
  }

}