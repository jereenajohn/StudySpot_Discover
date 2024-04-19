import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/instituteabout.dart';
import 'package:studyspot_discover/pages/instituteaboutupdate.dart';
import 'package:studyspot_discover/pages/instituteaddcourse.dart';
import 'package:studyspot_discover/pages/institutehome.dart';

import 'package:studyspot_discover/pages/loginpage.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  List AboutList = [""];
  var CompanyDescList = {};
  var categorylist = {};

  var PhoneNumberList = {};
  var EmailAddress = {};
  var Address = {};
  var Pincode = {};
  var idlist = [];
  var CompanyImageUrl = {};

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    User? user = auth.currentUser;
    String uid = user!.uid;
    print("==========================hooooiiiiiiiiii${uid}");

    DatabaseReference AboutDataRef =
        FirebaseDatabase.instance.ref("AboutInstitute");
    AboutDataRef.onValue.listen((DatabaseEvent event) {
      AboutList.clear();
      CompanyDescList.clear();
      PhoneNumberList.clear();
      EmailAddress.clear();
      CompanyImageUrl.clear();
      categorylist.clear();

      Address.clear();
      Pincode.clear();

      final AboutData = event.snapshot.value;

      setState(() {
        if (AboutData != null && AboutData is Map<Object?, Object?>) {
          AboutData.forEach((key, value) async {
            idlist.add(key);
            print("---------=================${idlist}");
            if (value != null && value is Map<Object?, Object?>) {
              if (uid == value['uid']) {
                var datav = value['CompanyName'];
                AboutList.add(datav);
                var des = value['CompanyDesc'];
                var category = value['Category'];

                var phno = value['PhoneNumber'];
                var email = value['EmailAddress'];
                var address = value['Address'];
                var pincode = value['Pincode'];

                try {
                  var Reference = FirebaseStorage.instance
                      .ref()
                      .child("Company-image/${datav.toString()}");
                  var tempurl = await Reference.getDownloadURL();
                  setState(() {
                    // CategoryImageUrl.add(tempurl);
                    CompanyImageUrl[datav] = tempurl;

                    CompanyDescList[datav] = des;
                    categorylist[datav] = category;

                    PhoneNumberList[datav] = phno;
                    EmailAddress[datav] = email;
                    Address[datav] = address;
                    Pincode[datav] = pincode;
                  });
                } catch (e) {
                  print(e);
                  print(e);
                }
              }
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
              title: Text("About"),
              leading: Icon(Icons.people),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InstituteAbout()));
              },
            ),
            ListTile(
              title: Text("Courses"),
              leading: Icon(Icons.category),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddCourses()));
              },
            ),
            ListTile(
              title: Text("Locations"),
              leading: Icon(Icons.location_city),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AddLocation()));
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
              "ABOUT INSTITUTE",
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
              itemCount: AboutList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyCard(
                    title: AboutList[index].toString(),
                    des:
                        CompanyDescList[AboutList[index].toString()].toString(),
                    category:
                        categorylist[AboutList[index].toString()].toString(),
                    phno:
                        PhoneNumberList[AboutList[index].toString()].toString(),
                    email: EmailAddress[AboutList[index].toString()].toString(),
                    address: Address[AboutList[index].toString()].toString(),
                    pincode: Pincode[AboutList[index].toString()].toString(),
                    photo:
                        CompanyImageUrl[AboutList[index].toString()].toString(),
                    id: idlist[index],
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
  final String title;
  final String des;
  final String category;
  final String phno;
  final String email;
  final String address;
  final String pincode;
  final String photo;
  final String id;

  MyCard(
      {required this.title,
      required this.des,
      required this.category,
      required this.phno,
      required this.email,
      required this.address,
      required this.pincode,
      required this.photo,
      required this.id});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.photo.toString(),
                width: 130.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    "Company Name:" + " " + widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Company Description:" + " " + widget.des.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Category:" + " " + widget.category.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Phone Number:" + " " + widget.phno,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Email:" + " " + widget.email,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Address:" + " " + widget.address,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Pincode:" + " " + widget.pincode,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AbouUpdate(id: widget.id)));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      minimumSize: Size(60.0, 0),
                    ),
                    child: Text(
                      'Update',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      DatabaseReference ref =
                          FirebaseDatabase.instance.ref("AboutInstitute");
                      await ref.child(widget.id.toString()).remove();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      minimumSize: Size(60.0, 0),
                    ),
                    child: Text(
                      'Delete',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
