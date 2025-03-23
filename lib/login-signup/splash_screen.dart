import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kharcha_book/login-signup/login_screen.dart';
import 'package:kharcha_book/services/auth_service.dart';

import '../screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      /// '''''''' Check if user is logged in or not ''''''''' ///
      if(AuthService().auth.currentUser != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
