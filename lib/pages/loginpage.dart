import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/admincategory.dart';
import 'package:studyspot_discover/pages/adminhome.dart';
import 'package:studyspot_discover/pages/institutionregistration.dart';
import 'package:studyspot_discover/pages/loginotp.dart';
import 'package:studyspot_discover/pages/registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController con1 = TextEditingController();
  TextEditingController con2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Container(
              child: Column(
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: con1,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        hintText: "Enter User Name "),
                  ),
                  SizedBox(height: 25),
                  TextField(
                      controller: con2,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          hintText: "Enter Phone number ")),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        var Phoneno = '+91${con2.text}';
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginOTP(
                                      phno: Phoneno,
                                    )));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text("OR"),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registration()));
                      },
                      child: Text("Student Registration")),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Institution_reg()));
                      },
                      child: Text("Institution Registration"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
