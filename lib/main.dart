import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kharcha_book/screens/add_expense_screen.dart';
import 'package:kharcha_book/screens/expense_details_screen.dart';
import 'package:kharcha_book/screens/forget_password_screen.dart';
import 'package:kharcha_book/screens/home_screen.dart';
import 'package:kharcha_book/screens/login_screen.dart';
import 'package:kharcha_book/screens/signup_screen.dart';
import 'package:kharcha_book/screens/splash_screen.dart';

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
      home: HomeScreen(),
    );
  }
}
