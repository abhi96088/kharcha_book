import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth_service.dart';
import '../my_colors.dart';
import '../widgets/my_texfields.dart';
import '../widgets/my_texts.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  // text editing controller to handle input fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // height and width of device
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // login form card
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
                    ///------------ Start of the form field -------------///
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120,
                        ),
                        Text(
                          "Signup",
                          style: TextStyle(
                              color: MyColors.primaryColor,
                              fontSize: 50,
                              fontFamily: "Lato-Bold"),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        /////////////// email field ///////////////
                        SizedBox(
                            width: screenWidth * 0.9,
                            child: MyTextField(
                              controller: emailController,
                              label: "Enter Email Id",
                              isPassword: false,
                              prefix: Icon(Icons.email, color: MyColors.primaryColor,),
                            )
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        /////////////// password field /////////////////
                        SizedBox(
                            width: screenWidth * 0.9,
                            child: MyTextField(
                              controller: passController,
                              label: "Enter Password",
                              isPassword: true,
                              prefix: Icon(Icons.lock, color: MyColors.primaryColor,),
                            )
                        ),
                        SizedBox(
                          height: 35,
                        ),

                        // ----------- signup button code ------------------//
                        SizedBox(
                          width: screenWidth * 0.9,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async{
                              final auth = AuthService(); // create instance of AuthServices
                              // call the signup method, passing text from email and password field
                              User? isCreated = await auth.signUp(emailController.text.toString(), passController.text.toString());

                              if(isCreated == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: MyTexts().errorText(16),
                                      backgroundColor: MyColors.primaryColor,));
                              }else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(
                                        "Account Created Successfully !",
                                        style: TextStyle(color: Colors.white,
                                            backgroundColor: MyColors
                                                .secondaryColor)
                                      ),
                                    )
                                );

                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));

                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.lock, color: Colors.white,size: 22,),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("SignUp",
                                    style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: "Roboto-SemiBold")),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("Already have an account ?", style: TextStyle(fontSize: 16),),
                        TextButton(
                            onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 22, color: MyColors.primaryColor),))
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 100,
                child: Container(
                  height: 200,
                  width: 200,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: MyColors.primaryColor, width: 3),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, -2),
                        )
                      ]),
                  child: Image(
                    image: AssetImage(
                      "assets/images/logo2.png",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
