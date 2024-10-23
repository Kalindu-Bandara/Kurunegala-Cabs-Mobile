import 'package:firebase_auth/firebase_auth.dart';
import 'package:sofrwere_project/pages/bottomnav.dart';
import 'package:sofrwere_project/pages/home.dart';
import 'package:sofrwere_project/pages/signup.dart';
import 'package:sofrwere_project/widget/support_widget.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "", password = "";

  TextEditingController mailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  // User login function with specific error handling
  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Bottomnav()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "No user found for that email or Wrong password provided by the user.Please check them .",
            style: TextStyle(fontSize: 16.0),
          ),
        ));
      } /*else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Wrong password provided by the user.",
            style: TextStyle(fontSize: 16.0),
          ),
        ));
      } else {
        // Handle other errors (optional)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Error: ${e.code}",
            style: TextStyle(fontSize: 16.0),
          ),
        ));
      }*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        "Sign In",
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
                            return 'Please enter your Email';
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
                        controller: passwordcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Password';
                          } else
                            return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        email = mailcontroller.text;
                        password = passwordcontroller.text;
                      });
                      userLogin(); // Call the login function here
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        "LOGIN",
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
                      "Don't have an account? ",
                      style: AppWidget.lightTextFeildStyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
