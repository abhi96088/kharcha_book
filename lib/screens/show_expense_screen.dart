import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kharcha_book/screens/add_expense_screen.dart';
import 'package:kharcha_book/services/database_services.dart';
import 'package:kharcha_book/ui_helper.dart';

class ShowExpenseScreen extends StatefulWidget {

  final String uid;
  const ShowExpenseScreen({super.key, required this.uid});

  @override
  State<ShowExpenseScreen> createState() => _ShowExpenseScreenState();
}

class _ShowExpenseScreenState extends State<ShowExpenseScreen> {

  // controllers to manage texts in text fields
  TextEditingController dateController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }

  DateTime initialDate = DateTime.now();  // hold initial date as current date

  // set initial date in  text field
  @override
  void initState() {
    super.initState();
    dateController.text = _formatDate(initialDate);
  }

  // function to show date picker
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        dateController.text = _formatDate(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    // height and width of device
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),

            /// ```````````````` Select date field ``````````````````` ///
            Row(
              children: [
                Text(
                  "Select Date: ",
                  style: TextStyle(fontSize: 22, fontFamily: "Roboto-Regular"),
                ),
                Spacer(),
                SizedBox(
                  width: screenWidth * 0.6,
                  height: 47,
                  child: TextField(
                    controller: dateController,
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        size: 40,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Roboto-Regular",
                      fontWeight: FontWeight.w600,
                    ),
                    onTap: () {
                      _pickDate();
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 20),

            /// ```````````````` Total of today field ``````````````````` ///
            Row(
              children: [
                Text(
                  "Total of today: ",
                  style: TextStyle(fontSize: 22, fontFamily: "Roboto-Regular"),
                ),
                Spacer(),
                SizedBox(
                  width: screenWidth * 0.4,
                  height: 47,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('expenses').doc(widget.uid).snapshots(),
                      builder: (context, snapshot){
                        if(!snapshot.hasData || !snapshot.data!.exists){
                          totalController.text = "0₹";
                          return TextField(
                            controller: totalController,
                            readOnly: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.red, width: 2.5),
                                ),
                            ),
                            style: TextStyle(fontSize: 35, color: Colors.red, fontFamily: "Roboto-Semibold"),
                          );
                        }

                        var data = snapshot.data!.data() as Map<String, dynamic>;

                        List<Map<String, dynamic>> expenseArray = [];

                        data.forEach((date, expenseList){
                          if(date.contains(dateController.text.toString()) && expenseList is List){
                            int total = 0;

                            for(var expense in expenseList){
                              if(expense is Map<String, dynamic> && expense.containsKey('amt')){
                                total += int.tryParse(expense['amt'].toString()) ?? 0;
                              }
                            }
                            totalController.text = "$total₹";
                          }
                        });
                        return TextField(
                          controller: totalController,
                          readOnly: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.red, width: 2.5),
                              )
                          ),
                          style: TextStyle(fontSize: 35, color: Colors.red, fontFamily: "Roboto-Semibold"),
                        );
                      }
                  )

                ),
                Spacer()
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 2,
              color: UiHelper.secondaryColor,
            ),
            SizedBox(
              height: screenHeight * 0.7,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('expenses').doc(widget.uid).snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData || !snapshot.data!.exists){
                      return  Center(
                          child: Text(
                            "No Expense Found",
                            style: TextStyle(
                                color: UiHelper.grey,
                                fontSize: 28,
                                fontFamily: "Roboto-Semibold"),
                          ));
                    }

                    var data = snapshot.data!.data() as Map<String, dynamic>;
                    List<Map<String, dynamic>> expenseArray = [];

                    data.forEach((date, expenseList){
                      if(date.contains(dateController.text.toString()) && expenseList is List){
                        expenseArray = expenseList.map((e) => e as Map<String, dynamic>).toList();
                      }
                    });

                    return expenseArray.isEmpty
                        ? Column(
                          children: [
                            SizedBox(height: 200,),
                            Text(
                              "No Expense Found",
                              style: TextStyle(
                                  color: UiHelper.grey,
                                  fontSize: 28,
                                  fontFamily: "Roboto-Semibold"),
                            ),
                          ],
                        ) :
                    ListView.builder(
                      itemCount: expenseArray.length,
                      itemBuilder: (context, index){
                        String title = expenseArray[index]['detail'];
                        String subtitle = expenseArray[index]['cat'];
                        String amount = expenseArray[index]['amt'];

                        return ListTile(
                          leading: Text("${index + 1}.", style: TextStyle(fontSize: 28),),
                          title: Text(title, style: TextStyle(fontSize: 22),),
                          subtitle: Text(subtitle),
                          trailing: Text("$amount₹", style: TextStyle(color: Colors.red, fontSize: 22),),
                        );
                      }
                    );
                  }
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async{
          await DatabaseServices().createDateExpense(widget.uid, dateController.text.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddExpenseScreen(date: dateController.text.toString(), uid: widget.uid,)));
        },
        backgroundColor: UiHelper.primaryColor,
        label: Text("Add Expense", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Roboto-Semibold"),),
      ),
    );
  }
}
