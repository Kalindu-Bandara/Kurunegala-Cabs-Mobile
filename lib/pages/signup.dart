import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'package:sofrwere_project/pages/bottomnav.dart';
import 'package:sofrwere_project/pages/login.dart';
import 'package:sofrwere_project/services/database.dart';
import 'package:sofrwere_project/services/shared_pref.dart';
import 'package:sofrwere_project/widget/support_widget.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? name, email, password;
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>(); // for checking the form state

  registration() async {
    if (password != null && name != null && email != null) {
      try {
        // Try to create the user with email and password
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);

        // If successful, show a success message and navigate to another page
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Registered Successfully",
            style: TextStyle(fontSize: 20.0),
          ),
        ));
        String Id=randomAlphaNumeric(10);
        await SharedPreferenceHelper().saveUserEmail(mailcontroller.text);
        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper().saveUserName(namecontroller.text);
        await SharedPreferenceHelper().saveUserImage("https://firebasestorage.googleapis.com/v0/b/shop-app-8627d.appspot.com/o/blogImage%2FVOUdoWzYZI?alt=media&token=567c1e2a-5666-42e7-bbb2-32f198253d6b");

        Map<String,dynamic>userInfoMap={
          "Name":namecontroller.text,
          "Email":mailcontroller.text,
          "Id":Id,
          "Image":"https://firebasestorage.googleapis.com/v0/b/shop-app-8627d.appspot.com/o/blogImage%2FVOUdoWzYZI?alt=media&token=567c1e2a-5666-42e7-bbb2-32f198253d6b",

        };
        //////////////////
        
        await DatabaseMethods().addUserDetails(userInfoMap,Id);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Bottomnav()));
      } on FirebaseAuthException catch (e) {
        // Handle specific Firebase errors here
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Password provided is too weak",
              style: TextStyle(fontSize: 20.0),
            ),
          ));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Account already exists",
              style: TextStyle(fontSize: 20.0),
            ),
          ));
        } else {
          // Handle other potential errors
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Registration failed. Error: ${e.message}",
              style: TextStyle(fontSize: 20.0),
            ),
          ));
        }
      } catch (e) {
        // General error handler
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "An unexpected error occurred: $e",
            style: TextStyle(fontSize: 20.0),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRect(
                      child: Align(
                        heightFactor: 0.8,
                        child: Image.asset(
                          "images/Login_page.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Center(
                      child: Text(
                        "Sign Up",
                        style: AppWidget.semiboldTextFeildStyle(),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Center(
                      child: Text(
                        "Please enter the details below to continue.",
                        textAlign: TextAlign.center,
                        style: AppWidget.lightTextFeildStyle(),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Name",
                      style: AppWidget.semiboldTextFeildStyle(),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xfff4f5f9),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          } else
                            return null;
                        },
                        controller: namecontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Name",
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Email",
                      style: AppWidget.semiboldTextFeildStyle(),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xfff4f5f9),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else
                            return null;
                        },
                        controller: mailcontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Password",
                      style: AppWidget.semiboldTextFeildStyle(),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xfff4f5f9),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else
                            return null;
                        },
                        controller: passwordcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            name = namecontroller.text;
                            email = mailcontroller.text;
                            password = passwordcontroller.text;
                          });
                          registration();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(15),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: AppWidget.lightTextFeildStyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
