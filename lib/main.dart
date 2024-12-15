import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/Pages/login.dart';
import 'package:music_app/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      
    );
  }
}
//===========================================================================================
class CreateAcc extends StatefulWidget {
  const CreateAcc({super.key});

  @override
  State<CreateAcc> createState() => _CreateAccState();
}

class _CreateAccState extends State<CreateAcc> {
  bool isObscurePassword =true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 80, 17, 13)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("       Create Account"),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(97, 28, 26, 26),
            ),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                color: Color.fromARGB(97, 15, 14, 14),
              ),
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.black54),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://via.placeholder.com/150', // Placeholder URL
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 12, 13, 14),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                  buildTextField("Name","Demon",false),
                  buildTextField("Email", "22kLk@W", false),
                  buildTextField("PassWord", "******", true),
                  buildTextField("Location", "Amman" ,false),
                  //====
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5,right:30,left: 30,top:6 ),
                    child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Cancel Button
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 170, 29, 29).withOpacity(0.8), // Shadow color
                              spreadRadius: 5,
                              blurRadius: 15,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: FilledButton(
                          onPressed: () {
                            // Action for Cancel button
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 21, 20, 20), // Background color for Cancel
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 1,
                              color: const Color.fromARGB(255, 134, 127, 127), // Text color
                            ),
                          ),
                        ),
                      ),
                    
                      // Save Button
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 188, 40, 40).withOpacity(0.8), // Shadow color
                              spreadRadius: 5,
                              blurRadius: 15,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: FilledButton(
                          onPressed: () {
                            // Action for Save button
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 16, 20, 16), // Background color for Save
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 2,
                              color: const Color.fromARGB(255, 140, 127, 127), // Text color
                            ),
                          ),
                        ),
                      ),
                    ],
                    
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

   Widget buildTextField(String labelText, String placeholder, bool isPasswordField){//change color of the label its the one 
    return Padding(padding: EdgeInsets.only(bottom: 30),
    child: TextField(
      obscureText: isPasswordField ? isObscurePassword: false,
      decoration: InputDecoration(
        suffixIcon: isPasswordField?
        IconButton(onPressed: (){}, 
        icon: Icon(Icons.remove_red_eye,color: Color.fromARGB(255, 249, 227, 227),),

        ):null,

        contentPadding: EdgeInsets.only(bottom: 5),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 170, 162, 162),
        )
      ),
    ),
    );
   }
}

 


