import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices{
  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;


  /// -------------------->  function to create user details <--------------------///
  Future<void> createUser(String name, String email, String uid) async{
    await fireStore.collection('users').doc(uid).set({
      'name' : name,
      'email' : email
    });

    await fireStore.collection('expenses').doc(uid).set({});

  }

  /// -------------------->  function to get userName <--------------------///
  Future<String> getUserName(String uid) async{
    DocumentSnapshot userData = await fireStore.collection('users').doc(uid).get();

    if(userData.exists){
      Map<String, dynamic> data = userData.data() as Map<String, dynamic>;

      return data['name'];
    }

    return "User";
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

}