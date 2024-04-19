import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studyspot_discover/pages/instituteaddcourse.dart';
import 'package:studyspot_discover/pages/institutehome.dart';
import 'package:studyspot_discover/pages/instituteplacementview.dart';
import 'package:studyspot_discover/pages/loginpage.dart';

class Placements_Add extends StatefulWidget {
  const Placements_Add({super.key});

  @override
  State<Placements_Add> createState() => _Placements_AddState();
}

class _Placements_AddState extends State<Placements_Add> {
  TextEditingController Caption = TextEditingController();
    FirebaseAuth auth = FirebaseAuth.instance;


  var SelectedFile;
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
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddCourses()));
              },
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
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Placements_Add()));
              },
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
            padding: const EdgeInsets.only(top: 120),
            child: Container(
              child: Column(
                children: [
                  Text(
                    "Add Placements",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        PlacementImageupload();
                      },
                      child: Text("Upload Image")),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: Caption,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        hintText: "Enter Caption"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        addplacement();
                      },
                      child: Text("ADD")),

                      SizedBox(height: 20,),

                      ElevatedButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>placement_view()));
                      }, child: Text("view"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void PlacementImageupload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          SelectedFile = File(result.files.single.path!);
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("File selecting Successfully"),
          backgroundColor: Color.fromARGB(255, 35, 143, 51),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("error selecting the file"),
        backgroundColor: Colors.red,
      ));
    }
  }

  void addplacement() async {
    try {
        User? user = auth.currentUser;
        String uid =user!.uid;
      var docpath = await getApplicationDocumentsDirectory();
      var path = "${docpath.absolute}.png";
      if (SelectedFile != null) {
        await FirebaseStorage.instance
            .ref()
            .child("placement-image/${Caption.text}")
            .putFile(SelectedFile);
      }
      if (Caption.text.isNotEmpty) {
        DatabaseReference ref = FirebaseDatabase.instance.ref("placements");
        DatabaseReference cat = ref.push();

        await cat.set({
          "uid":uid,
          "Caption": Caption.text,
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Placements_Add()));
      } else {
        print("fill out the fields");
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("File selecting Successfully"),
        backgroundColor: Color.fromARGB(255, 35, 143, 51),
      ));
    } catch (e) {
      print(e);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("File selecting Successfully ${e}"),
        backgroundColor: Color.fromARGB(255, 146, 40, 40),
      ));
    }
  }
}
