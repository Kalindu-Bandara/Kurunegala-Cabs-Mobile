import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sofrwere_project/Admin/home_admin.dart';
import 'package:sofrwere_project/widget/support_widget.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
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
                      "Admin Panel",
                      style: AppWidget.semiboldTextFeildStyle(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Username",
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
                      controller: usernamecontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "UserName",
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
                      controller: userpasswordcontroller,
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
                      loginAdmin(); // Call the login function when button is pressed
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
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
            ],
          ),
        ),
      ),
    );
  }

  void loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['username'] != usernamecontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Your username is not correct",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        } else if (result.data()['password'] != userpasswordcontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Your password is not correct",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeAdmin()));
        }
      });
    });
  }
}
