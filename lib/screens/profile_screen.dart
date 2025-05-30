import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kharcha_book/login-signup/login_screen.dart';
import 'package:kharcha_book/screens/about_us_screen.dart';
import 'package:kharcha_book/screens/edit_profile_screen.dart';
import 'package:kharcha_book/services/auth_service.dart';
import 'package:kharcha_book/widgets/custom_texts.dart';
import 'package:kharcha_book/widgets/my_texfields.dart';

import '../services/database_services.dart';
import '../ui_helper.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController emailController = TextEditingController();
  String name = "User";
  String? profileUrl;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  /// -------------------->  function to get userName <--------------------///
  Future<void> getUserData() async {
    final data = await DatabaseServices().getUserData(widget.uid);

    if (data != null) {
      name = data['name'];
      emailController.text = data['email'];
      profileUrl = data['photoUrl'] ?? null;
    }
    setState(() {});
  }

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 140,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: "Lato-Bold"),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit),
                              SizedBox(
                                width: 5,
                              ),
                              Text("edit profile")
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ///////////////////////// email field /////////////////////////
                    SizedBox(
                        width: screenWidth * 0.9,
                        child: MyTextField(
                          controller: emailController,
                          isFilled: true,
                          readOnly: true,
                          isPassword: false,
                          prefix: Icon(
                            Icons.email,
                            color: UiHelper.primaryColor,
                          ),
                        )),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Divider(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutUsScreen()));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: Row(
                          children: [
                            CustomTexts.h6(
                                text: "About Us", color: Colors.black),
                            Spacer(),
                            CustomTexts.h6(text: ">", color: Colors.black)
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    SizedBox(
                      width: screenWidth * 0.9,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          AuthService().logOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(color: Colors.red, width: 2)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.red,
                              size: 22,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Logout",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 22,
                                    fontFamily: "Roboto-SemiBold")),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          ///~~~~~~~~~~~~~~~~~~~~~ profile picture ~~~~~~~~~~~~~~~~~~~~~~~~~~///
          Positioned(
            top: 100,
            child: Container(
              height: screenHeight * 0.2,
              width: screenHeight * 0.2,
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
                child: CircleAvatar(
                    child: profileUrl != null ? ClipOval(
                      child: Image.network(
                        profileUrl!,
                        height: screenHeight * 0.2,
                        width: screenHeight * 0.2,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SpinKitFadingCircle(color: UiHelper.primaryColor, size: screenHeight * 0.15,);
                        },
                      ),
                    ) : Icon(
                      Icons.person,
                    )
                ),
            )
          )
        ],
      )),
    );
  }
}
