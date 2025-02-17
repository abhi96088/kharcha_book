import 'package:flutter/material.dart';
import 'package:kharcha_book/login-signup/signup_screen.dart';
import 'package:kharcha_book/services/auth_service.dart';
import 'package:kharcha_book/ui_helper.dart';
import 'package:kharcha_book/widgets/my_texfields.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 70,),
            Text("Enter Your Registered Email Id",
              style: TextStyle(color: UiHelper.primaryColor, fontSize: 22, fontFamily: "Roboto-Semibold"),
            ),
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
                    final _auth = AuthService();
                    if(emailController.text.isNotEmpty){
                      bool isExist = await _auth.isUserExist(emailController.text.toString());
                      
                      if(isExist){
                        await _auth.resetPassword(emailController.text.toString());

                        UiHelper().snackBar(
                            context,
                            "Email Sent Successfully ... Check Your Mail",
                            Colors.white,
                            UiHelper.secondaryColor
                        );
                      }else{
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
