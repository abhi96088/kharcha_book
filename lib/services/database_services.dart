import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseServices{
  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;


  /// -------------------->  function to create user details <--------------------///
  Future<void> createUser(String name, String email, String uid) async{
    await fireStore.collection('users').doc(uid).set({
      'name' : name,
      'email' : email
    });

    await fireStore.collection('expenses').doc(uid).set({});

  }

  /// -------------------->  function to get userDetails <--------------------///
  Future<Map<String, dynamic>?> getUserData(String uid) async{
    DocumentSnapshot userData = await fireStore.collection('users').doc(uid).get();

    if(userData.exists){
      return await userData.data() as Map<String, dynamic>;
    }

    return null;
  }

  /// -------------------->  function to create date wise expense details <--------------------///
  Future<void> createDateExpense(String uid, String date) async{

    DocumentSnapshot docSnap = await fireStore.collection('expenses').doc(uid).get();

    if(docSnap.exists){
      Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;

      if(!data.containsKey(date)){
        await fireStore.collection('expenses').doc(uid).set({
          date: []
        }, SetOptions(merge: true));
      }
    }

  }

  /// -------------------->  function to create unit expense <--------------------///
  Future<void> createUnitExpense(String uid, String date, String amount, String detail, String category) async{
    await fireStore.collection('expenses').doc(uid).update({
      date: FieldValue.arrayUnion([
        {
          'amt': amount,
          'detail': detail,
          'cat': category
        }
      ])
    });
  }

  /// -------------------->  function to update profile picture <--------------------///
  Future<String> updateDp(File imageFile, String uid) async{
    // Upload image to Firebase Storage
    UploadTask uploadTask = storage
        .ref('profile_pictures/$uid.jpg')
        .putFile(imageFile);

    TaskSnapshot snapshot = await uploadTask;

    return await snapshot.ref.getDownloadURL();
  }

  /// -------------------->  function to update profile picture URL <--------------------///
  Future<void> updateProfileUrl(String url, String uid) async{
    await fireStore.collection('users').doc(uid).update({
      'photoUrl' : url
    });

  }

  /// -------------------->  function to update account details <--------------------///
  Future<void> updateDetails(String uid, String name, String email) async{
    await fireStore.collection('users').doc(uid).update({
      'name': name,
      'email': email
    });

  }
}