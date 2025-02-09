import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kharcha_book/services/auth_service.dart';
import 'package:kharcha_book/ui_helper.dart';
import 'package:kharcha_book/widgets/my_texfields.dart';

class ExpenseDetailsScreen extends StatefulWidget {
  const ExpenseDetailsScreen({super.key});

  @override
  State<ExpenseDetailsScreen> createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  // text controllers to handle text inside text fields
  TextEditingController amountController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  final _fireStore = FirebaseFirestore.instance;
  List<String> _categoryList = [];

  @override
  void initState(){
    super.initState();
    _fetchCategory();
  }

  Future<void> _fetchCategory() async{
    DocumentSnapshot docSnap = await _fireStore.collection("category").doc("rnqELX5qYrt43rKvhZEi").get();

    if(docSnap.exists){
      Map<String, dynamic> _data = docSnap.data() as  Map<String, dynamic>;

      setState(() {
        _categoryList = _data.values.map((values) => values.toString()).toList();
      });

    }else{
      print("Document does not exist");
    }
  }
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
                                itemBuilder: (BuildContext, index) {
                                  return ListTile(
                                    horizontalTitleGap: 80,contentPadding: EdgeInsets.symmetric(horizontal: 40),
                                    leading: Text("${index + 1}", style: TextStyle(fontSize: 18),),
                                    title: Text(_categoryList[index]),
                                  );
                                },
                              ),
                            ));
                  }),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
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
