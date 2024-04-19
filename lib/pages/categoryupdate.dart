import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studyspot_discover/pages/adminhome.dart';
import 'package:studyspot_discover/pages/adminlocation.dart';
import 'package:studyspot_discover/pages/adminviewinstitute.dart';
import 'package:studyspot_discover/pages/categoryview.dart';
import 'package:studyspot_discover/pages/loginpage.dart';

class CategoryUpdate extends StatefulWidget {
  var id;
  CategoryUpdate({required this.id});

  @override
  State<CategoryUpdate> createState() => _CategoryUpdateState();
}

class _CategoryUpdateState extends State<CategoryUpdate> {
  TextEditingController catname = TextEditingController();
  TextEditingController catdes = TextEditingController();
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
                    MaterialPageRoute(builder: (context) => AdminHome()));
              },
            ),
            ListTile(
              title: Text("Institutions"),
              leading: Icon(Icons.people),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminViewInstitutes()));
              },
            ),
            ListTile(
              title: Text("Locations"),
              leading: Icon(Icons.location_city),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddLocation()));
              },
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
            padding: const EdgeInsets.only(top: 150),
            child: Container(
              child: Column(
                children: [
                  Text(
                    "ADD CATEGORY",
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
                    controller: catname,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        hintText: "Enter Type Of Institution"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: catdes,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        hintText: "Enter description"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        CategoryImageupload();
                      },
                      child: Text("Upload File")),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        UpdateCategory();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryView()));
                      },
                      child: Text("update")),
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

  void CategoryImageupload() async {
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

  void UpdateCategory() async {
    try {
      var docpath = await getApplicationDocumentsDirectory();
      var path = "${docpath.absolute}.png";
      if (SelectedFile != null) {
        await FirebaseStorage.instance
            .ref()
            .child("category-image/${catname.text}")
            .putFile(SelectedFile);
      }
      if (catname.text.isNotEmpty && catdes.text.isNotEmpty) {
        DatabaseReference ref = FirebaseDatabase.instance.ref("Category");

        await ref.update({
          "${widget.id.toString()}/Categoryname": catname.text,
          "${widget.id.toString()}/Categorydes": catdes.text,
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CategoryView()));
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
