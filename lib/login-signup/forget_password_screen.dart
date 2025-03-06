import 'package:flutter/material.dart';
import 'package:kharcha_book/login-signup/signup_screen.dart';
import 'package:kharcha_book/services/auth_service.dart';
import 'package:kharcha_book/ui_helper.dart';
import 'package:kharcha_book/widgets/custom_texts.dart';
import 'package:kharcha_book/widgets/my_texfields.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  // text editing controller to handle text inside field
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 70,),
            CustomTexts.h6(text: "Enter Your Registered Email Id", color: UiHelper.primaryColor),
            SizedBox(height: 20,),
            MyTextField(
              controller: emailController,
              isPassword: false,
              prefix: Icon(Icons.email, color: UiHelper.primaryColor, size: 30,),
              isUnderlined: true,
              hint: "Enter Email Id",
            ),
            SizedBox(height: 30,),
            SizedBox(
              height: 50,
              width: 200,
              child: OutlinedButton(
                  onPressed: () async{
                    final auth = AuthService();  // instance of auth class
                    if(emailController.text.isNotEmpty){  // check if text field is not empty
                      // check if user exists or not
                      bool isExist = await auth.isUserExist(emailController.text.toString());
                      
                      if(isExist){
                        // send password reset link if user exists
                        await auth.resetPassword(emailController.text.toString());

                        // show snack bar to notify user
                        UiHelper().snackBar(
                            context,
                            "Email Sent Successfully ... Check Your Mail",
                            Colors.white,
                            UiHelper.secondaryColor
                        );
                      }else{
                        // notify user if user does not exists
                        UiHelper().snackBar(
                            context,
                            "User does not exist!! Create an account first",
                            Colors.white,
                            Colors.red
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                      }
                    }else{
                      UiHelper().snackBar(
                          context,
                          "Please enter registered email id",
                          Colors.white,
                          Colors.red
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                    side: BorderSide(color: UiHelper.primaryColor, width: 2)
                  ),
                  child: Text("Send Email", style: TextStyle(color: UiHelper.primaryColor, fontFamily: "Roboto-Semibold", fontSize: 22, letterSpacing: 1.5),)),
            )
          ],
        ),
      ),
    );
  }
}
