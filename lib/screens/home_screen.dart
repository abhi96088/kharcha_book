import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kharcha_book/screens/profile_screen.dart';
import 'package:kharcha_book/screens/show_expense_screen.dart';
import 'package:kharcha_book/screens/detailed_expense_view_screen.dart';
import 'package:kharcha_book/services/auth_service.dart';
import 'package:kharcha_book/services/database_services.dart';
import 'package:kharcha_book/ui_helper.dart';
import 'package:kharcha_book/widgets/custom_texts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // get current month
  String getMonth = DateFormat('MM-yyyy').format(DateTime.now());
  String getMonthName = DateFormat('MMMM').format(DateTime.now());

  // get uid of current user
  String uid = AuthService().auth.currentUser!.uid;

  // get instance of database
  final database = DatabaseServices.fireStore;

  // username
  String username = "User";

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void getUserName() async{
    Map<String, dynamic>? userData = await DatabaseServices().getUserData(uid);

    if(userData != null){
      username = userData['name'];
    }
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {

    // get device's screen height
    final screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),
        title: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(uid: uid,)));
            },
            child: Text(username)
      ),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            /// !!!!!!!!!!!!!!!!!!! Card contains sum of total expense of current month !!!!!!!!!!!!!!!! ///
            SizedBox(
              height: screenHeight * 0.15,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailedExpenseViewScreen(uid: uid,)));
                },
                child: Card(
                  elevation: 4,
                  shadowColor: UiHelper.secondaryColor,
                  color: UiHelper.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTexts.h6(text: "Total of this month : "),
                          // stream builder get data dynamically from the database
                          StreamBuilder(
                              stream: database
                                  .collection('expenses')
                                  .doc(uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                // check if there is any expense record in particular uid
                                if (!snapshot.hasData || !snapshot.data!.exists) {
                                  return Text(
                                    "0₹",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 40,
                                        fontFamily: "Lato-Bold",
                                        fontWeight: FontWeight.bold),
                                  );
                                }
                      
                                // store data as a Map
                                var data =
                                    snapshot.data!.data() as Map<String, dynamic>;
                      
                                int totalSum = 0;   // variable to add sum of amount
                      
                                // iterate over each record and check if record has matching date as current month
                                data.forEach((date, expenseList) {
                                  if (date.contains(getMonth) &&
                                      expenseList is List) {
                                    for (var expense in expenseList) {
                                      if (expense is Map<String, dynamic> &&
                                          expense.containsKey('amt')) {
                                        // add amount
                                        totalSum +=
                                            int.tryParse(expense['amt'].toString()) ??
                                                0;
                                      }
                                    }
                                  }
                                });
                                return CustomTexts.bigAmountText("$totalSum");
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ////////////////// month name //////////////////
            Align(
              alignment: Alignment.centerLeft,
              child: CustomTexts.h6(text: getMonthName.toUpperCase(), color: UiHelper.secondaryColor, size: 28)
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
                height: screenHeight * 0.6,
                child: StreamBuilder(
                    stream: database
                        .collection('expenses')
                        .doc(uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return Center(
                            child: Text(
                          "No Expense Found",
                          style: TextStyle(
                              color: UiHelper.grey,
                              fontSize: 28,
                              fontFamily: "Roboto-Semibold"),
                        ));
                      }
                      var data = snapshot.data!.data() as Map<String, dynamic>;
                      List<Map<String, dynamic>> expenseArray = []; // store each expense in a list of map

                      // iterate over each record
                      data.forEach((date, expenseList) {
                        if (date.contains(getMonth) && expenseList is List) {
                          int dailyTotal = 0; // store total of a particular day

                          for (var expense in expenseList) {
                            if (expense is Map<String, dynamic> &&
                                expense.containsKey('amt')) {
                              dailyTotal +=
                                  int.tryParse(expense['amt'].toString()) ?? 0;
                            }
                          }
                          // store date and daily total in a map
                          expenseArray.add({"date": date, "total": dailyTotal});
                        }
                      });

                      // sort the date in descending order
                      expenseArray.sort((a, b) {
                        return DateTime.parse(
                            b['date'].split('-').reversed.join('-'))
                            .compareTo(DateTime.parse(
                            a['date'].split('-').reversed.join('-')));
                      });

                      return expenseArray.isEmpty
                          ? Center(
                              child: CustomTexts.h6(text: "No Expense Found", color: UiHelper.grey, size: 28)
                            )
                          : ListView.builder(

                              itemCount: expenseArray.length,
                              itemBuilder: (context, index){

                                String date = expenseArray[index]['date'];
                                int total = expenseArray[index]['total'];
                                String day = date.split('-')[0];

                                return InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowExpenseScreen(uid: uid, date: date)));
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            minRadius: 30,
                                            backgroundColor:
                                            UiHelper.primaryColor,
                                            child: Text(
                                              day,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontFamily: "Roboto-SemiBold",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          CustomTexts.h6(text: "Total Expense: ", color: Colors.black, size: 25),
                                          Spacer(),
                                          CustomTexts.h6(text: "$total₹", size: 30, color: Colors.red),
                                          SizedBox(
                                            width: 15,
                                          )
                                        ],
                                      ),
                                      Divider()
                                    ],
                                  ),
                                );
                              });
                    }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ShowExpenseScreen(uid: uid,)));
        },
        backgroundColor: Colors.deepOrange,
        label: Text(
          "Add Expense",
          style: TextStyle(
              color: Colors.white, fontFamily: "Roboto-SemiBold", fontSize: 16),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
