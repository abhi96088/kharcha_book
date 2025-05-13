import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:kharcha_book/ui_helper.dart';
import 'package:kharcha_book/widgets/custom_texts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'pixelcrafters.apps@gmail.com',
      queryParameters: {
        'subject': 'KharchaBook Feedback',
        'body': 'Hi Abhimanyu,',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email client';
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo2.png'),
              radius: screenHeight * 0.08,
            ),
            SizedBox(height: 10),
            CustomTexts.h1(text: "KharchaBook", size: 35),
            SizedBox(height: 10),
            Text(
              'KharchaBook is a Flutter-based expense tracker app with Firebase authentication and real-time expense management.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Developed by: ', style: TextStyle(fontSize: 16)),
                Text(
                  "Abhi Manyu",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tech Stack:   '),
                Text(
                  'Flutter • Dart • Firebase',
                  style: TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.2),
            SizedBox(
              width: screenWidth * 0.5,
              height: screenHeight * 0.06,
              child: ElevatedButton.icon(
                icon: Icon(Icons.email, size: 25,),
                label: Text("Contact Us", style: TextStyle(color: UiHelper.primaryColor, fontSize: 18),),
                style: ElevatedButton.styleFrom(
                  iconColor: UiHelper.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )
                ),
                onPressed: _launchEmail,
              ),
            )
          ],
        ),
      ),
    );
  }
}
