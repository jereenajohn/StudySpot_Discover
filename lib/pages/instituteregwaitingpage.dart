import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/loginpage.dart';

class Institute_reg_waiting extends StatelessWidget {
  const Institute_reg_waiting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration Waiting')),
      body: Container(
        child: Column(
          children: [Text("Wait until your verification gets completed"),
          ElevatedButton(onPressed: () async {
           
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => LoginPage()));
                print('Buttonpressed');
              
          }, child: Text("Logout"))
          
          ],
        ),
        
      ),
      
    );
  }
}