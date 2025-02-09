import 'package:flutter/material.dart';
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
            SizedBox(height: 50,),
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
                  onPressed: () {},
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
