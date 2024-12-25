import 'package:flutter/material.dart';
import 'package:music_app/CustomWidgets/CustomTextField.dart';
import 'package:music_app/CustomWidgets/custom-Button.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/Views/auth/signin.dart';
import 'package:music_app/homePage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController UserNameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

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
                        hintText: "UserName", controller: UserNameController),
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

  Widget _Page() {
    return LayoutBuilder(
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
                    const SizedBox(height: 30),
                    CustomTextField(
                        hintText: "UserName", controller: UserNameController),
                    const SizedBox(height: 30),
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
    );
  }

  Widget _icon() {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
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
            debugPrint("UserName: " + UserNameController.text);
            debugPrint("Password: " + PasswordController.text);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
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
            Text(
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
                child: Text(
                  "sign in now",
                  style: TextStyle(decoration: TextDecoration.underline),
                ))
          ],
        ),
      ],
    );
  }
}
