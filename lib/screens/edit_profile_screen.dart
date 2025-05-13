import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kharcha_book/services/database_services.dart';
import 'package:kharcha_book/ui_helper.dart';
import 'package:kharcha_book/widgets/my_texfields.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final database = DatabaseServices();
  String profilePicture = '';

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    Map<String, dynamic>? userData = await database.getUserData(uid);

    if (userData != null) {
      nameController.text = userData['name'];
      emailController.text = userData['email'];
    }
    setState(() {

    });
  }

  void saveProfile() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Name and email cannot be empty')),
      );
      return;
    }

    await database.updateDetails(uid, name, email);

    if (password.isNotEmpty) {
      if (cPassword.isNotEmpty && password == cPassword) {
        await FirebaseAuth.instance.currentUser!.updatePassword(password);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please Confirm Your Password Correctly!')),
        );
      }
    }

    getData();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile updated successfully')),
    );
  }

  void saveDp() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No image selected')),
        );
        return;
      }

      File imageFile = File(pickedFile.path);

      // Upload image to Firebase Storage
      String downloadUrl = await database.updateDp(imageFile, uid);

      profilePicture = downloadUrl;

      // Update photo URL in Firebase Auth profile
      await database.updateProfileUrl(downloadUrl, uid);

      getData();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile picture updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: saveDp,
                child: CircleAvatar(
                  backgroundImage: profilePicture.isNotEmpty
                      ? NetworkImage(profilePicture)
                      : null,
                  child: profilePicture.isEmpty ? Icon(Icons.person, size: screenHeight * 0.15,) : null,
                  radius: screenHeight * 0.1,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              MyTextField(
                controller: nameController,
                isPassword: false,
                label: "Full Name",
              ),
              SizedBox(height: screenHeight * 0.016),
              MyTextField(
                controller: emailController,
                isPassword: false,
                label: "Email Address",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: screenHeight * 0.016),
              if (showPassword)
                MyTextField(
                  controller: passwordController,
                  isPassword: true,
                  label: "New Password",
                ),
              SizedBox(height: screenHeight * 0.016),
              if (showPassword)
                MyTextField(
                  controller: cPasswordController,
                  isPassword: false,
                  label: "Confirm Password",
                ),
              TextButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                child: Text(
                  showPassword ? 'Hide Password Field' : 'Change Password?',
                  style: TextStyle(color: UiHelper.primaryColor),
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
              SizedBox(
                height: screenHeight * 0.06,
                width: screenWidth * 0.8,
                child: ElevatedButton(
                    onPressed: saveProfile,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: UiHelper.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "Save Changes",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
