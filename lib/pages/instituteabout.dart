import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studyspot_discover/pages/instituteaboutview.dart';
import 'package:studyspot_discover/pages/institutehome.dart';
import 'package:studyspot_discover/pages/loginpage.dart';

class InstituteAbout extends StatefulWidget {
  const InstituteAbout({super.key});

  @override
  State<InstituteAbout> createState() => _InstituteAboutState();
}

class _InstituteAboutState extends State<InstituteAbout> {
  TextEditingController AddCompanyName = TextEditingController();
  TextEditingController AddCompanyDesc = TextEditingController();
  TextEditingController AddPhno = TextEditingController();

  TextEditingController AddEmail = TextEditingController();
  TextEditingController AddAddress = TextEditingController();
  TextEditingController AddPincode = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
    var SelectedFile;
      String selectedValue1 = '';
        List<String> Categorylist = [];
@override
void initState() {
    // TODO: implement initState
    super.initState();
        fetchcategory();


  }

  void fetchcategory() async {
    DatabaseReference yeardataref = FirebaseDatabase.instance.ref("Category");

   await yeardataref.onValue.listen((DatabaseEvent event) {
      Categorylist.clear();
      var data = event.snapshot.value;
      setState(() {
        if (data != null && data is Map<Object?, Object?>) {
          data.forEach((key, value) async {
            if (value != null && value is Map<Object?, Object?>) {
              var cat = value["Categoryname"];
              Categorylist.add(cat.toString());
              selectedValue1 = cat.toString();
              print(Categorylist);
            }
          });
        }
      });
    });
  }




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
              title: Text("Institutions"),
              leading: Icon(Icons.people),
              // onTap: () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => AdminViewInstitutes()));
              // },
            ),
            ListTile(
              title: Text("Category"),
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
                    "About Institute",
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
                    controller: AddCompanyName,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        hintText: "Enter Company Name"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: AddCompanyDesc,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        hintText: "Enter Description"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                   Container(
                    width: 340,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Select Category',
                        labelText: 'Category',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      child: DropdownButton<String>(
                        value: selectedValue1,
                        onChanged: (String? newValue1) {
                          setState(() {
                            selectedValue1 = newValue1!;
                            print(selectedValue1);
                          });
                        },
                        items: Categorylist.map<DropdownMenuItem<String>>(
                            (String value1) {
                          return DropdownMenuItem<String>(
                            value: value1,
                            child: Text(value1),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    controller: AddPhno,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        hintText: "Enter Phone Number"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: AddEmail,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        hintText: "Enter Email Address"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: AddAddress,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        hintText: "Enter Address"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: AddPincode,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        hintText: "Enter Pincode"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        SelectImage();
                      },
                      child: Text("Upload Image")),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                       UploadImage();

                        User? user = auth.currentUser;
                          String uid =user!.uid;
                        if (AddCompanyName.text.isNotEmpty &&
                            AddCompanyDesc.text.isNotEmpty &&
                            AddPhno.text.isNotEmpty &&
                            AddEmail.text.isNotEmpty &&
                            AddAddress.text.isNotEmpty &&
                            AddPincode.text.isNotEmpty) {
                          DatabaseReference ref =
                              FirebaseDatabase.instance.ref("AboutInstitute");
                          DatabaseReference cat = ref.push();

                          await cat.set({
                            "uid":uid,
                            "CompanyName": AddCompanyName.text,
                            "CompanyDesc": AddCompanyDesc.text,
                             "Category": selectedValue1,
                            "PhoneNumber": AddPhno.text,
                            "EmailAddress": AddEmail.text,
                            "Address": AddAddress.text,
                            "Pincode": AddPincode.text,
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InstituteAbout()));
                        } else {
                          print("fill out the fields");
                        }
                      },
                      child: Text("Add")),

                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutView()));
                      },
                      child: Text("View"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  void SelectImage() async {
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
  
   void UploadImage() async {
    try {
      var docpath = await getApplicationDocumentsDirectory();
      var path = "${docpath.absolute}.png";
      if (SelectedFile != null) {
        await FirebaseStorage.instance
            .ref()
            .child("Company-image/${AddCompanyName.text}")
            .putFile(SelectedFile);
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
