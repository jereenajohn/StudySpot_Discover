import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyspot_discover/main.dart';
import 'package:studyspot_discover/pages/AuthProvider.dart';
import 'package:studyspot_discover/pages/loginpage.dart';

class LoginOTP extends StatelessWidget {
  var phno;
  LoginOTP({required this.phno});
  TextEditingController con3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvide>(context, listen: false).phonesignin(phno);

    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 180, left: 20, right: 20),
          child: Column(
            children: [
              TextField(
                  controller: con3,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      hintText: "Enter OTP ")),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    await Provider.of<AuthProvide>(context, listen: false)
                        .loginUser(con3.text,phno);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AuthChecker()));
                  },
                  child: Text("Verify")),
            ],
          ),
        ),
      ),
    );
  }
}
