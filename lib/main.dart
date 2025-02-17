import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kharcha_book/login-signup/splash_screen.dart';
import 'package:kharcha_book/screens/show_expense_screen.dart';
import 'package:kharcha_book/screens/detailed_expense_view_screen.dart';
import 'package:kharcha_book/screens/add_expense_screen.dart';
import 'package:kharcha_book/screens/home_screen.dart';
import 'package:kharcha_book/login-signup/login_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
