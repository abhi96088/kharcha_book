import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kharcha_book/services/database_services.dart';
import 'package:kharcha_book/ui_helper.dart';
import 'package:kharcha_book/widgets/my_texfields.dart';

class AddExpenseScreen extends StatefulWidget {

  final String date;
  final String uid;
  const AddExpenseScreen({super.key, required this.date, required this.uid});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  // text controllers to handle text inside text fields
  TextEditingController amountController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  // final _fireStore = FirebaseFirestore.instance;
  final List<String> _categoryList = ["Grocery", "Sports", "Stationary", "Rent", "Pary", "Others"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              SizedBox(
                height: 60,
              ),
              MyTextField(
                label: "Enter Amount",
                controller: amountController,
                isPassword: false,
                enabledColor: UiHelper.grey,
                isFilled: true,
                prefix: Icon(
                  Icons.currency_rupee,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MyTextField(
                label: "Enter Detail",
                controller: detailController,
                isPassword: false,
                enabledColor: UiHelper.grey,
                isFilled: true,
                prefix: Icon(Icons.info),
              ),
              SizedBox(
                height: 15,
              ),
              MyTextField(
                  controller: categoryController,
                  hint: "Select Category",
                  prefix: Icon(Icons.category),
                  readOnly: true,
                  isPassword: false,
                  enabledColor: UiHelper.grey,
                  isFilled: true,
                  suffix: Icon(Icons.arrow_drop_down),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                           child: ListView.builder(
                             shrinkWrap: true,
                             itemCount: _categoryList.length,
                             itemBuilder: (context, index) {
                               return ListTile(
                                 horizontalTitleGap: 80,
                                 contentPadding:
                                 EdgeInsets.symmetric(horizontal: 40),
                                 leading: Text(
                                   "${index + 1}",
                                   style: TextStyle(fontSize: 18),
                                 ),
                                 title: Text(_categoryList[index]),
                                 onTap: () {
                                   setState(() {
                                     categoryController.text =
                                     _categoryList[index];
                                   });
                                   Navigator.pop(context);
                                 },
                               );
                             }
                           )
                        ));
                  }),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async{
                      if(amountController.text.isNotEmpty && detailController.text.isNotEmpty && categoryController.text.isNotEmpty){
                        await DatabaseServices().createUnitExpense(
                            widget.uid,
                            widget.date,
                            amountController.text.toString(),
                            detailController.text.toString(),
                            categoryController.text.toString()
                        );
                        Navigator.pop(context);
                      }else{
                        UiHelper().snackBar(
                            context,
                            "Enter All Field",
                            Colors.white,
                            Colors.red
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: UiHelper.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Roboto-Semibold",
                          fontSize: 22,
                          letterSpacing: 1.5),
                    )),
              )
            ])));
  }
}
