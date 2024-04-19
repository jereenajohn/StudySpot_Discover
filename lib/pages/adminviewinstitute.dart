import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studyspot_discover/main.dart';
import 'package:studyspot_discover/pages/admincategory.dart';
import 'package:studyspot_discover/pages/adminhome.dart';
import 'package:studyspot_discover/pages/adminlocation.dart';
import 'package:studyspot_discover/pages/loginpage.dart';
import 'package:http/http.dart' as http;

class AdminViewInstitutes extends StatefulWidget {
  const AdminViewInstitutes({super.key});

  @override
  State<AdminViewInstitutes> createState() => _AdminViewInstitutesState();
}

class _AdminViewInstitutesState extends State<AdminViewInstitutes> {
  List InstitutephnoList = [""];
  var InstituteName = {};
  var email = {};
  var location = {};
  var LicenseImageUrl = {};
  List idList = [];
  List mainid = [];
  List subid = [];
  @override
  void initState() {
    super.initState();

    DatabaseReference categoryDataRef = FirebaseDatabase.instance.ref("users");
    categoryDataRef.onValue.listen((DatabaseEvent event) {
      InstitutephnoList.clear();
      InstituteName.clear();
      email.clear();
      location.clear();
      LicenseImageUrl.clear();
      subid.clear();
      mainid.clear();

      final InstituteData = event.snapshot.value;

      setState(() {
        if (InstituteData != null && InstituteData is Map<Object?, Object?>) {
          InstituteData.forEach((key, value) async {
            mainid.add(key);
            print("2222222222222222222222222222222222222222222---${mainid}");

            if (value != null && value is Map<Object?, Object?>) {
              value.forEach((key, value) async {
                subid.add(key);
                print("2222222222222222222222222222222222222222222---${subid}");
                if (value != null && value is Map<Object?, Object?>) {
                  if (value['institute'] == "true") {
                    var datav = value['phno'];
                    idList.add(datav);

                    InstitutephnoList.add(datav);
                    var Iname = value['fname'];
                    var Iemail = value['email'];
                    var ILocation = value['location'];

                    print("-----------------------------------------${Iname}");

                    try {
                      var Reference = FirebaseStorage.instance
                          .ref()
                          .child("license-image/${Iname.toString()}");
                      var tempurl = await Reference.getDownloadURL();
                      setState(() {
                        // CategoryImageUrl.add(tempurl);
                        LicenseImageUrl[datav] = tempurl;
                        InstituteName[datav] = Iname;
                        email[datav] = Iemail;
                        location[datav] = ILocation;
                      });
                    } catch (e) {
                      print("ereerrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr$e");
                      print(e);
                    }
                  }
                }
              });

              // }

              // print(
              //     "-----------------------=====================--------------------------------key: $datav");
              // print("((((((((((()))))))))))))))))((((((((((((((())))))))))))))))))$CategoryImageUrl");
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
                    MaterialPageRoute(builder: (context) => AdminHome()));
              },
            ),
            // ListTile(
            //   title: Text("Institutions"),
            //   leading: Icon(Icons.people),
            //   onTap: () {},
            // ),
            ListTile(
              title: Text("Category"),
              leading: Icon(Icons.category),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminCategory()));
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Institutes",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.purple, // Set the text color to purple
                fontFamily: 'YourFontFamily', // Set the desired font family
                fontWeight: FontWeight.bold, // Set the font weight if needed
                fontStyle: FontStyle.italic, // Set the font style if needed
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: InstitutephnoList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyCard(
                    phno: InstitutephnoList[index].toString(),
                    name: InstituteName[InstitutephnoList[index].toString()]
                        .toString(),
                    photo: LicenseImageUrl[InstitutephnoList[index].toString()]
                        .toString(),
                    email:
                        email[InstitutephnoList[index].toString()].toString(),
                    location: location[InstitutephnoList[index].toString()]
                        .toString(),
                    mainid: mainid[index],
                    subid: subid[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyCard extends StatefulWidget {
  final String phno;
  final String name;
  final String email;
  final String photo;
  final String location;
  final String mainid;
  final String subid;

  MyCard(
      {required this.phno,
      required this.name,
      required this.email,
      required this.location,
      required this.photo,
      required this.mainid,
      required this.subid});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  var LicenseImageUrl;

  void _showLargerImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); // Dismiss the dialog on tap
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Image.network(
                widget.photo.toString(),
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

 @override
Widget build(BuildContext context) {
  return Card(
    elevation: 3,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _showLargerImage(context); // Call the method to show larger image
            },
            child: Image.network(
              widget.photo.toString(),
              width: 130.0,
              height: 130.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10), // Add some spacing between image and details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.phno,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.email,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.location,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10), // Add some spacing between details and buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        DatabaseReference ref =
                            FirebaseDatabase.instance.ref("users");

                        print(
                            "${widget.subid.toString()}/${widget.mainid.toString()}/status");

                        try {
                          await ref.update({
                            "${widget.mainid.toString()}/${widget.subid.toString()}/status":
                                "accept"
                          });
                        } catch (e) {
                          print("kkkkkkkkkkklllllllllll$e");
                        }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminViewInstitutes()));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        minimumSize: Size(60.0, 0),
                      ),
                      child: Text(
                        'Accept',
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        minimumSize: Size(60.0, 0),
                      ),
                      child: Text(
                        'Reject',
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

}
