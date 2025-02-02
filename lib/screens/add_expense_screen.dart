import 'package:flutter/material.dart';
import 'package:kharcha_book/ui_helper.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  // controllers to manage texts in text fields
  TextEditingController dateController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  DateTime initialDate = DateTime.now();  // hold initial date as current date

  // set initial date in  text field
  @override
  void initState() {
    super.initState();
    dateController.text =
        "${initialDate.day}/${initialDate.month}/${initialDate.year}";
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
        dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    // height and width of device
    final screenWidth = MediaQuery.of(context).size.width;

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
                  child: TextField(
                    controller: totalController,
                    readOnly: true,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.5))),
                  ),
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
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: UiHelper.primaryColor,
        label: Text("Add Expense", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Roboto-Semibold"),),
      ),
    );
  }
}
