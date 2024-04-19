import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/otp.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registration> {
  TextEditingController con11 = TextEditingController();
  TextEditingController con22 = TextEditingController();
  TextEditingController con33 = TextEditingController();
  TextEditingController con44 = TextEditingController();
  // TextEditingController con55 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
              child: Column(
                children: [
                  Text(
                    "Create New Account",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    controller: con11,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      hintText: "Enter First Name ",
                    ),
                  ),
                  SizedBox(height: 25),
                  TextField(
                      controller: con22,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          hintText: "Enter Last Name")),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                      controller: con33,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          hintText: "Enter Email ")),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                      controller: con44,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          hintText: "Enter Phone Number")),
                  SizedBox(
                    height: 25,
                  ),
                  // TextField(
                  //     controller: con55,
                  //     decoration: InputDecoration(
                  //         contentPadding: EdgeInsets.symmetric(
                  //             vertical: 10, horizontal: 15),
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(18.0),
                  //         ),
                  //         hintText: "Enter Password ")),
                  // SizedBox(
                  //   height: 25,
                  // ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        var Phoneno = '+91${con44.text}';

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OTP(
                                      Fname: con11.text,
                                      Lname: con22.text,
                                      email: con33.text,
                                      phno: Phoneno,
                                      // Password: con55.text,
                                    )));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
