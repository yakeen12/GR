import 'package:flutter/material.dart';
import 'package:music_app/CustomWidgets/CustomTextField.dart';
import 'package:music_app/CustomWidgets/custom-Button.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/CustomWidgets/img.dart';
import 'package:music_app/Models/auth_model.dart';
import 'package:music_app/ViewModels/auth.dart';
import 'package:music_app/methods.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? selectedImagePath;

  // bool isObscurePassword = true;
  void signIn() async {
    final authViewModel = AuthViewModel();

    final userName = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    // Validate the email and passwords
    if (!isEmailValid(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid email address')));
      return;
    }

    if (userName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid user name')));
      return;
    }
    if (!doPasswordsMatch(password, confirmPassword)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }
    AuthModel model = AuthModel(
        username: userName,
        email: email,
        password: password,
        profilePicture: selectedImagePath);
    final isValid = await authViewModel.registerUser(model,
        profileImagePath: selectedImagePath);

    if (isValid == "تم تسجيل المستخدم بنجاح") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign in successful!')),
      );
      // Navigate to another screen here
      Navigator.pop(context);
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign in failed. Please try again.')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: "Create Account",
        body: Container(
          padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                ProfileImagePicker(
                    onImageSelected: (path) => selectedImagePath = path),
                const SizedBox(height: 30),
                CustomTextField(
                  hintText: "Name",
                  controller: nameController,
                ),
                CustomTextField(hintText: "Email", controller: emailController),
                CustomTextField(
                    isPassword: true,
                    hintText: "PassWord",
                    controller: passwordController),
                CustomTextField(
                    isPassword: true,
                    hintText: "Confirm Password",
                    controller: confirmPasswordController),
                //====
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 5, right: 30, left: 30, top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Cancel Button
                      SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          child: CustomButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: "Cancel",
                          )),

                      // Save Button
                      SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          child: CustomButton(
                            text: "save",
                            onPressed: signIn,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
