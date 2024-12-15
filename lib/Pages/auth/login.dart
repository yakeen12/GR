import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/Pages/auth/signin.dart';
import 'package:music_app/homePage.dart';
import 'package:music_app/main.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController UserNameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 80, 17, 13)
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _Page(),
      ),
    );
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
                    _inputfield("UserName", UserNameController),
                    const SizedBox(height: 30),
                    _inputfield("Password", PasswordController,
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
          'assets/my_image.png',
          width: 230,
          height: 179,
          fit: BoxFit.cover, // Adjust how the image fits within the space
        ),
      ),
    );
  }

  Widget _inputfield(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.black));
    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 96, 75, 75)),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
    );
  }

  Widget _loginbtn() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("UserName: " + UserNameController.text);
        debugPrint("Password: " + PasswordController.text);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      },
      child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.5,
          child: Text(
            "Login ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          )),
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        primary: Color.fromARGB(255, 104, 2, 2),
        onPrimary: Color.fromARGB(255, 18, 4, 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  Widget _extraText() {
    return Column(
      children: [
        Text(
          'Or login with',
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Facebook Login Button
            SizedBox(
              width: 120,
              height: 55,
              child: TextButton(
                onPressed: () {
                  print('Facebook Login Pressed');
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.facebook, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'FB',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Google Login Button
            SizedBox(
              width: 120,
              height: 55,
              child: TextButton(
                onPressed: () {
                  print('Google Login Pressed');
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.g_mobiledata,
                        color: Colors.white), // Google logo
                    SizedBox(width: 8),
                    Text(
                      'Google',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
                          builder: (context) => const CreateAcc()));
                },
                style: TextButton.styleFrom(foregroundColor: Colors.grey),
                child: Text(
                  "sign in now",
                  style: TextStyle(decoration: TextDecoration.underline),
                ))
          ],
        ),
        const Text(
          "have a problem?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 88, 82, 82),
          ),
        ),
      ],
    );
  }
}
