import 'package:flutter/material.dart';
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

  bool showPassword = false;

  void saveProfile() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Name and email cannot be empty')),
      );
      return;
    }

    // Add your Firebase update logic here
    // Example:
    // FirebaseAuth.instance.currentUser!.updateDisplayName(name);
    // FirebaseAuth.instance.currentUser!.updateEmail(email);
    // if (password.isNotEmpty) FirebaseAuth.instance.currentUser!.updatePassword(password);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile updated successfully')),
    );
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
        child: Column(
          children: [
            CircleAvatar(
             backgroundImage: AssetImage('assets/images/logo2.png'),
              radius: screenHeight * 0.1,
            ),
            SizedBox(height: screenHeight * 0.03,),
            MyTextField(controller: nameController, isPassword: false, label: "Full Name",),
            SizedBox(height: screenHeight * 0.016),
            MyTextField(controller:emailController, isPassword: false, label: "Email Address", keyboardType: TextInputType.emailAddress,),
            SizedBox(height: screenHeight * 0.016),
            if (showPassword)
              MyTextField(controller:passwordController, isPassword: true, label: "New Password",),
            SizedBox(height: screenHeight * 0.016),
            if (showPassword)
              MyTextField(controller:cPasswordController, isPassword: false, label: "Confirm Password",),
            TextButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              child: Text(showPassword ? 'Hide Password Field' : 'Change Password?', style: TextStyle(color: UiHelper.primaryColor),),
            ),
            SizedBox(height: screenHeight * 0.1),
            SizedBox(
              height: screenHeight * 0.06,
              width: screenWidth * 0.8,
              child: ElevatedButton(onPressed: saveProfile, style: ElevatedButton.styleFrom(
                  backgroundColor: UiHelper.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),child: Text("Save Changes", style: TextStyle(color: Colors.white, fontSize: 20),)),
            )
          ],
        ),
      ),
    );
  }
}
