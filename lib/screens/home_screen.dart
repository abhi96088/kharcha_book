import 'package:flutter/material.dart';
import 'package:kharcha_book/ui_helper.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic>? userData;
  const HomeScreen({super.key, this.userData});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          title: Text(widget.userData?['name'] ?? 'User'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.15,
                child: Card(
                  elevation: 4,
                  shadowColor: UiHelper.secondaryColor,
                  color: UiHelper.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total of this month : ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: "Roboto-Semibold"),
                      ),
                      Text(
                        " 4568₹",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 40,
                            fontFamily: "Lato-Bold",
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                  child: Text("JANUARY", style: TextStyle(color: UiHelper.secondaryColor, fontSize: 28, fontFamily: "Roboto-Semibold"),),

              ),
              Divider(color: Colors.black,),
              SizedBox(
                height: screenHeight * 0.6,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => Column(children: [Row(
                      children: [
                        CircleAvatar(
                          minRadius: 30,
                          backgroundColor: UiHelper.primaryColor,
                          child: Text("15", style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: "Roboto-SemiBold", fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(width: 15,),
                        Text("Pizza party", style: TextStyle(fontSize: 25, fontFamily: "Roboto-SemiBold"),),
                        Spacer(),
                        Text("512₹", style: TextStyle(color: Colors.red, fontSize: 30, fontFamily: "Roboto-SemiBold"),),
                        SizedBox(width: 15,)
                      ],
                    ),
                    Divider()],)
                )
              )
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        backgroundColor: Colors.deepOrange,
        label: Text("Add Expense", style: TextStyle(color: Colors.white, fontFamily: "Roboto-SemiBold", fontSize: 16),),
        icon: Icon(Icons.add, color: Colors.white,size: 28,),
      ),
    );
  }
}
