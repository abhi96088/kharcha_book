import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:kharcha_book/ui_helper.dart';
import 'package:kharcha_book/widgets/custom_texts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {

  void _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'pixelcrafters.apps@gmail.com',
      query: Uri.encodeFull('subject=KharchaBook Feedback&body=Hi Abhimanyu,'),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      debugPrint('Could not launch email client');
      // Optionally show a snackbar or dialog here
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
              'KharchaBook helps you take control of your spending by tracking your daily expenses and keeping your budget on track — all in one place.',
              style: TextStyle(fontSize: 18, fontFamily: "Roboto-Semibold"),
              textAlign: TextAlign.center,
            ),
            Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Made with ❤️ by ', style: TextStyle(fontSize: 16, fontFamily: "Roboto-Regular")),
                Text(
                  "Abhi Manyu",
                  style: TextStyle(fontSize: 18, fontFamily: "Roboto-Semibold"),
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
