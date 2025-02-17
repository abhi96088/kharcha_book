import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kharcha_book/ui_helper.dart';

class DetailedExpenseViewScreen extends StatefulWidget {

  const DetailedExpenseViewScreen({super.key,});

  @override
  State<DetailedExpenseViewScreen> createState() => _DetailedExpenseViewScreenState();
}

class _DetailedExpenseViewScreenState extends State<DetailedExpenseViewScreen> {

  String getMontName = DateFormat("MMMM").format(DateTime.now());
  String getMonth = DateFormat('MM-yyyy').format(DateTime.now());
  String totalExpense = "2415₹";
  String uid = "JOeVl5MOdtQLfGkGLXcqg0FVRVO2";

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(height: 50,),
          SizedBox(height: screenHeight * 0.2,
          child: Card(
            color: UiHelper.primaryColor,
            shadowColor: UiHelper.secondaryColor,
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("total in", style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: "Robot-Regular"),),
                      Text(getMontName.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 35, fontFamily: "Roboto-Semibold"),)
                    ],
                  ),
                  Spacer(),
                  Text(totalExpense, style: TextStyle(color: Colors.red, fontSize: 35, fontFamily: "Roboto-Semibold"),)
                ],
              ),
            ),
          ),),
          SizedBox(height: 20,),
          Text("Expense by Category", style: TextStyle(color: UiHelper.secondaryColor, fontSize: 30, fontFamily: "Roboto-Regular"),),
          Divider(
            color: UiHelper.secondaryColor,
            thickness: 1,
          ),
          SizedBox(
            height: screenHeight * 0.6,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('expenses').doc(uid).snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData || !snapshot.data!.exists){
                    return Center(
                      child: Text("No Expense Found", style: TextStyle(color: UiHelper.grey, fontSize: 25, fontFamily: "Roboto-Semibold"),),
                    );
                  }

                  var data = snapshot.data!.data() as Map<String, dynamic>;
                  Map<String, int>  categoryTotal = {};

                  data.forEach((date, expenseList){
                    if(date.contains(getMonth) && expenseList is List){
                      for (var expense in expenseList){
                        if(expense is Map<String, dynamic> && expense.containsKey('amt') && expense.containsKey('cat')){
                          int amount = int.tryParse(expense['amt'].toString()) ?? 0;
                          String category = expense['cat'];

                          categoryTotal[category] = (categoryTotal[category] ?? 0) + amount;
                        }
                      }
                    }
                  });

                  if (categoryTotal.isEmpty) {
                    return Center(
                      child: Text(
                        "No Expenses Found",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    );
                  }

                  List<MapEntry<String, int>> categoryList =  categoryTotal.entries.toList();

                  return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 1.5),
                          itemCount: categoryList.length,
                          itemBuilder: (context, index){

                            var category = categoryList[index].key;
                            var totalAmount = categoryList[index].value;

                            return Card(
                              color: UiHelper.secondaryColor,
                              elevation: 3,
                              shadowColor: UiHelper.primaryColor,
                              child: Column(
                                children: [
                                  Spacer(),
                                  Text(category, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: "Roboto-Semibold"),),
                                  Spacer(),
                                  Text("$totalAmount₹", style: TextStyle(color: Colors.red, fontSize: 35, fontFamily: "Roboto-Semibold"),),
                                  Spacer()
                                ],
                              ),
                            );
                          });

                })
          )
        ],
      ),),
    );
  }
}
