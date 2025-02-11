import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  /// -------------------->  function to create user details <--------------------///
  Future<void> createUser(String name, String email, String uid) async{
    await _firestore.collection('users').doc(uid).set({
      'name' : name,
      'email' : email
    });

    await _firestore.collection('expenses').doc(uid).set({});

  }

  /// -------------------->  function to create date wise expense details <--------------------///
  Future<void> createDateExpense(String uid, String date) async{

    DocumentSnapshot docSnap = await _firestore.collection('expenses').doc(uid).get();

    if(docSnap.exists){
      Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;

      if(!data.containsKey(date)){
        await _firestore.collection('expenses').doc(uid).set({
          date: []
        }, SetOptions(merge: true));
      }
    }

  }

  /// -------------------->  function to create date wise expense details <--------------------///
  Future<void> createUnitExpense(String uid, String date, String amount, String detail, String category) async{
    await _firestore.collection('expenses').doc(uid).update({
      date: FieldValue.arrayUnion([
        {
          'amt': amount,
          'detail': detail,
          'cat': category
        }
      ])
    });
  }
}