import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/instituteaboutview.dart';
import 'package:studyspot_discover/pages/institutehome.dart';
import 'package:studyspot_discover/pages/loginpage.dart';

class AbouUpdate extends StatefulWidget {
  var id;
  AbouUpdate({required this.id});

  @override
  State<AbouUpdate> createState() => _AbouUpdateState();
}

class _AbouUpdateState extends State<AbouUpdate> {
  TextEditingController AddCompanyName = TextEditingController();
  TextEditingController AddCompanyDesc = TextEditingController();
  TextEditingController AddPhno = TextEditingController();

  TextEditingController AddEmail = TextEditingController();
  TextEditingController AddAddress = TextEditingController();
  TextEditingController AddPincode = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                    "Update Institute",
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

                  // ElevatedButton(
                  //     onPressed: () {
                  //       CategoryImageupload();
                  //     },
                  //     child: Text("Upload File")),
                  // SizedBox(
                  //   height: 20,
                  // ),

                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (AddCompanyName.text.isNotEmpty &&
                            AddCompanyDesc.text.isNotEmpty &&
                            AddPhno.text.isNotEmpty &&
                            AddEmail.text.isNotEmpty &&
                            AddAddress.text.isNotEmpty &&
                            AddPincode.text.isNotEmpty) {
                          DatabaseReference ref =
                              FirebaseDatabase.instance.ref("AboutInstitute");

                          await ref.update({
                            "${widget.id.toString()}/CompanyName":
                                AddCompanyName.text,
                            "${widget.id.toString()}/CompanyDesc":
                                AddCompanyDesc.text,
                            "${widget.id.toString()}/PhoneNumber": AddPhno.text,
                            "${widget.id.toString()}/EmailAddress":
                                AddEmail.text,
                            "${widget.id.toString()}/Address": AddAddress.text,
                            "${widget.id.toString()}/Pincode": AddPincode.text,
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutView()));
                        } else {
                          print("fill out the fields");
                        }
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
}
