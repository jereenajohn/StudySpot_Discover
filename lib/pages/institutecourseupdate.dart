import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/institutecourseview.dart';
import 'package:studyspot_discover/pages/institutehome.dart';
import 'package:studyspot_discover/pages/loginpage.dart';

class CourseUpdate extends StatefulWidget {
  var id;
  CourseUpdate({required this.id});

  @override
  State<CourseUpdate> createState() => _CourseUpdateState();
}

class _CourseUpdateState extends State<CourseUpdate> {
  TextEditingController CourseName = TextEditingController();
  TextEditingController CourseDuration = TextEditingController();
  TextEditingController CourseFee = TextEditingController();

  TextEditingController NextBatchOpening = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  backgroundColor: Colors.transparent, // Make the app bar transparent
  flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple, Colors.black87], // Set the gradient colors
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ),
),

      drawer: Drawer(
        child: ListView(
          children: <Widget>[
           DrawerHeader(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.purple, Colors.black87], // Set the gradient colors
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.only(top: 32.0),
    child: Text(
      "Dashboard",
      style: TextStyle(
        fontSize: 24.0,
        color: Color.fromARGB(255, 252, 252, 253),
      ),
    ),
  ),
),

            ListTile(
              title: Text("Home"),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InstituteHome()));
              },
            ),
            ListTile(
              title: Text("Courses"),
              leading: Icon(Icons.people),
              // onTap: () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => AdminViewInstitutes()));
              // },
            ),
            ListTile(
              title: Text("Enquires"),
              leading: Icon(Icons.category),
              // onTap: () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => AdminCategory()));
              // },
            ),
            ListTile(
              title: Text("Registred users"),
              leading: Icon(Icons.category),
              // onTap: () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => AdminCategory()));
              // },
            ),
            ListTile(
              title: Text("Placements"),
              leading: Icon(Icons.category),
              // onTap: () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => AdminCategory()));
              // },
            ),
            ListTile(
              title: Text("Placement Videos"),
              leading: Icon(Icons.category),
              // onTap: () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => AdminCategory()));
              // },
            ),
            ListTile(
              title: Text('logout'),
              leading: Icon(Icons.logout),
              onTap: () async {
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => LoginPage()));
                print('Buttonpressed');
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Container(
              child: Column(
                children: [
                  Text(
                    "Update Courses",
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
                    controller: CourseName,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        hintText: "Enter Course Name"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: CourseDuration,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        hintText: "Enter course duration"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: CourseFee,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        hintText: "Enter course fee"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: NextBatchOpening,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        hintText: "Enter Next Opening"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (CourseName.text.isNotEmpty &&
                            CourseDuration.text.isNotEmpty &&
                            CourseFee.text.isNotEmpty &&
                            NextBatchOpening.text.isNotEmpty) {
                          DatabaseReference ref =FirebaseDatabase.instance.ref("Courses");

                          await ref.update({
                            "${widget.id.toString()}/CourseName": CourseName.text,
                            "${widget.id.toString()}/CourseDuration": CourseDuration.text,
                            "${widget.id.toString()}/CourseFee": CourseFee.text,
                            "${widget.id.toString()}/NextBatchOpening": NextBatchOpening.text
                           
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CourseView()));
                        } else {
                          print("fill out the fields");
                        }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CourseView()));
                      },
                      child: Text("Update")),
                  SizedBox(
                    height: 20,
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
