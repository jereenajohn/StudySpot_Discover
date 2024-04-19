import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/instituteabout.dart';
import 'package:studyspot_discover/pages/instituteaddcourse.dart';
import 'package:studyspot_discover/pages/institutehome.dart';
import 'package:studyspot_discover/pages/loginpage.dart';

class View_reg_users extends StatefulWidget {
  const View_reg_users({super.key});

  @override
  State<View_reg_users> createState() => _View_reg_usersState();
}

class _View_reg_usersState extends State<View_reg_users> {
  List RegusersList = [""];
  var coursename = {};
  var PhoneNumber = {};
  var idlist = [];

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    User? user = auth.currentUser;
    String uid = user!.uid;
    print("==========================hooooiiiiiiiiii${uid}");

    DatabaseReference AboutDataRef = FirebaseDatabase.instance.ref("enquiry");
    AboutDataRef.onValue.listen((DatabaseEvent event) {
      RegusersList.clear();
      coursename.clear();
      PhoneNumber.clear();

      final RegusersData = event.snapshot.value;

      setState(() {
        if (RegusersData != null && RegusersData is Map<Object?, Object?>) {
          RegusersData.forEach((key, value) async {
            idlist.add(key);
            print("---------=================${idlist}");
            if (value != null && value is Map<Object?, Object?>) {
              if (uid == value['instid']) {
                var datav = value['name'];
                RegusersList.add(datav);
                var course = value['coursename'];

                var phno = value['phno'];

                try {
                  setState(() {
                    coursename[datav] = course;
                    PhoneNumber[datav] = phno;
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
              colors: [
                Colors.purple,
                Colors.black87
              ], // Set the gradient colors
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Registered Users",
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
              itemCount: RegusersList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyCard(
                    name: RegusersList[index].toString(),
                    courses:
                        coursename[RegusersList[index].toString()].toString(),
                    phone:
                        PhoneNumber[RegusersList[index].toString()].toString(),
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
  final String name;
  final String courses;
  final String phone;
  final String id;

  MyCard(
      {required this.name,
      required this.courses,
      required this.phone,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    "Name:" + " " + widget.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Course:" + " " + widget.courses.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Phone Number:" + " " + widget.phone,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
