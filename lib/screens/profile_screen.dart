import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kharcha_book/login-signup/login_screen.dart';
import 'package:kharcha_book/services/auth_service.dart';
import 'package:kharcha_book/widgets/my_texfields.dart';

import '../services/database_services.dart';
import '../ui_helper.dart';

class ProfileScreen extends StatefulWidget {

  final String uid;
  const ProfileScreen({super.key, required this.uid});


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  TextEditingController emailController = TextEditingController();

  /// -------------------->  function to get userName <--------------------///
  Future<String> getUserName() async{
    DocumentSnapshot userData = await DatabaseServices.fireStore.collection('users').doc(widget.uid).get();

    if(userData.exists){
      Map<String, dynamic> data = userData.data() as Map<String, dynamic>;

      return data['name'];
    }

    return "User";
  }

  @override
  Widget build(BuildContext context) {

    emailController.text = "abimanyu290@gmail.com";

    // height and width of device
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: UiHelper.bgColor,
      body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              /// ``````````````````````` login form card ````````````````````````///
              Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.2,
                  ),
                  Container(
                    height: screenHeight * 0.8,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(15), right: Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          )
                        ]),
                    ///--------------------- Start of the form field ----------------------///
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 140,
                        ),
                        FutureBuilder<String>(future: getUserName(), builder: (context, snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Text("Loading...");
                          }
                          return Text(snapshot.data ?? 'User',  style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: "Lato-Bold"),);
                        }),
                        SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(onPressed: (){}, child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: 5,),
                              Text("edit profile")
                            ],
                          )),
                        ),
                        SizedBox(height: 25,),
                        ///////////////////////// email field /////////////////////////
                        SizedBox(
                            width: screenWidth * 0.9,
                            child: MyTextField(
                              controller: emailController,
                              isFilled: true,
                              readOnly: true,
                              isPassword: false,
                              prefix: Icon(Icons.email, color: UiHelper.primaryColor,),
                            )
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        ///::::::::::::::::::::::::::::::: login button code ::::::::::::::::::::::::::::::::::::::::::::::::///
                        SizedBox(
                          width: screenWidth * 0.9,
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () {
                              AuthService().logOut();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                ),
                              side: BorderSide(color: Colors.red, width: 2)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.logout, color: Colors.red,size: 22,),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Logout",
                                    style: TextStyle(color: Colors.red, fontSize: 22, fontFamily: "Roboto-SemiBold")),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ///~~~~~~~~~~~~~~~~~~~~~ logo of application visible on top ~~~~~~~~~~~~~~~~~~~~~~~~~~///
              Positioned(
                top: 100,
                child: Container(
                  height: 200,
                  width: 200,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: UiHelper.primaryColor, width: 3),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, -2),
                        )
                      ]),
                  child: Icon(Icons.person, size: 150,)
                ),
              )
            ],
          )
      ),
    );
  }
}
