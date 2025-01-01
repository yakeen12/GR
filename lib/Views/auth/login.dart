import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/CustomTextField.dart';
import 'package:music_app/CustomWidgets/custom-Button.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/Models/auth_model.dart';
import 'package:music_app/ViewModels/auth.dart';
import 'package:music_app/Views/auth/signin.dart';
import 'package:music_app/homePage.dart';
import 'package:music_app/methods.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  void logIn() async {
    final authViewModel = AuthViewModel();

    final email = emailController.text;
    final password = PasswordController.text;

    // Validate the email and passwords
    if (!isEmailValid(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid email address')));
      return;
    }

    AuthModel model = AuthModel(
      email: email,
      password: password,
    );
    final isValid = await authViewModel.login(model);

    if (isValid == "Login Successful") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign in successful!')),
      );
      // Navigate to another screen here

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('login in failed. Please try again.')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(body: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _icon(),
                    const SizedBox(height: 10),
                    CustomTextField(
                        hintText: "Email", controller: emailController),
                    const SizedBox(height: 10),
                    CustomTextField(
                        hintText: "Password",
                        controller: PasswordController,
                        isPassword: true),
                    const SizedBox(height: 30),
                    _loginbtn(),
                    const SizedBox(height: 20),
                    _extraText(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ));
  }

  // Widget _Page() {
  //   return LayoutBuilder(
  //     builder: (BuildContext context, BoxConstraints constraints) {
  //       return SingleChildScrollView(
  //         child: ConstrainedBox(
  //           constraints: BoxConstraints(
  //             minHeight: constraints.maxHeight,
  //           ),
  //           child: IntrinsicHeight(
  //             child: Padding(
  //               padding: const EdgeInsets.all(32.0),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   _icon(),
  //                   const SizedBox(height: 30),
  //                   CustomTextField(
  //                       hintText: "UserName", controller: emailController),
  //                   const SizedBox(height: 30),
  //                   CustomTextField(
  //                       hintText: "Password",
  //                       controller: PasswordController,
  //                       isPassword: true),
  //                   const SizedBox(height: 30),
  //                   _loginbtn(),
  //                   const SizedBox(height: 20),
  //                   _extraText(),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _icon() {
    return Container(
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
          //border: Border.all(color: const Color.fromARGB(255, 2, 2, 2),width: 2),
          shape: BoxShape.circle),
      child: Center(
        child: Image.asset(
          'assets/images/rg.png',
          width: 150,
          height: 140,
          fit: BoxFit.cover, // Adjust how the image fits within the space
        ),
      ),
    );
  }

  Widget _loginbtn() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.5,
      child: CustomButton(
          onPressed: () {
            logIn();
          },
          text: "Login"),
    );
  }

  Widget _extraText() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Not yet signed in?',
              style: TextStyle(color: Colors.grey),
            ),
            TextButton(
                onPressed: () {
                  
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInView()));
                },
                style: TextButton.styleFrom(foregroundColor: Colors.grey),
                child: const Text(
                  "sign in now",
                  style: TextStyle(decoration: TextDecoration.underline),
                ))
          ],
        ),
      ],
    );
  }
}
