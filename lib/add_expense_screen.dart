import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  TextEditingController dateController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    dateController.text = "${initialDate.day}/${initialDate.month}/${initialDate.year}";
  }

  Future<void> _pickDate() async{
    DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2025),
        lastDate: DateTime.now(),
    );

    if(picked != null){
      setState(() {
        dateController.text = "${picked.day}/${picked.month}/${picked.year}";
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
            SizedBox(height: 50,),
            Row(
              children: [
                Text("Select Date: ", style: TextStyle(fontSize: 22, fontFamily: "Roboto-Regular"),),
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
                      suffixIcon: Icon(Icons.arrow_drop_down, size: 40,),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Roboto-Regular",
                      fontWeight: FontWeight.w600,

                    ),
                    onTap: (){
                      _pickDate();
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Total of today: ", style: TextStyle(fontSize: 22, fontFamily: "Roboto-Regular"),),
                Spacer(),
                SizedBox(
                  width: screenWidth * 0.4,
                  height: 47,
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.5
                        )
                      )
                    ),
                  ),
                ),
                Spacer()
              ],
            )
          ],
        ),
      ),
    );
  }
}
