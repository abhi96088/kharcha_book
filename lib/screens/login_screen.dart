import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kharcha_book/screens/forget_password_screen.dart';
import 'package:kharcha_book/screens/home_screen.dart';
import 'package:kharcha_book/services/auth_service.dart';
import 'package:kharcha_book/screens/signup_screen.dart';
import '../ui_helper.dart';
import '../widgets/my_texfields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // text editing controller to handle input fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // height and width of device
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: UiHelper.bgColor,
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
                      "Login",
                      style: TextStyle(
                          color: UiHelper.primaryColor,
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
                        prefix: Icon(Icons.email, color: UiHelper.primaryColor,),
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
                        prefix: Icon(Icons.lock, color: UiHelper.primaryColor,),
                      )
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // -------- forget password text -------- //
                    SizedBox(
                      width: screenWidth * 0.9,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen()));
                            },
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                  color: UiHelper.primaryColor, fontSize: 16),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // login button code
                    SizedBox(
                      width: screenWidth * 0.9,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async{
                          final auth = AuthService(); // instance of authServices class

                          // check if fields are not empty
                          if(emailController.text == "" || passController.text == "") {
                            // show snack bar to inform user to enter email and password
                            UiHelper().snackBar(
                                context, "Please enter email and password !!",
                                Colors.white, Colors.red);
                          }else{
                            // invoke login method
                            Map<String, dynamic>? isLogin = await auth.logIn(
                                emailController.text.toString(),
                                passController.text.toString()
                            );

                            // check if login is successful
                            if(isLogin != null){
                              // navigate to home screen with user data
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(userData: isLogin,)));
                            }else{
                              // show snack bar to inform user about failure
                              UiHelper().snackBar(context, "Something Went Wrong ! Try Again...", Colors.white, Colors.red);
                            }

                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: UiHelper.primaryColor,
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
                            Text("Login",
                                style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: "Roboto-SemiBold")),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("Don't have an account ?", style: TextStyle(fontSize: 16),),
                    TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(fontSize: 22, color: UiHelper.primaryColor),))
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
