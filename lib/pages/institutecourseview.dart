import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/instituteabout.dart';
import 'package:studyspot_discover/pages/instituteaddcourse.dart';
import 'package:studyspot_discover/pages/institutecourseupdate.dart';
import 'package:studyspot_discover/pages/institutehome.dart';

import 'package:studyspot_discover/pages/loginpage.dart';

class CourseView extends StatefulWidget {
  const CourseView({super.key});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  List CourseList = [""];
  var CourseDuration = {};
  var CourseFee = {};
  var NextBatchOpening = {};
  List idlist = [];
  var SyllabusImageUrl = {};

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    User? user = auth.currentUser;
    String uid = user!.uid;

    DatabaseReference CourseDataRef = FirebaseDatabase.instance.ref("Courses");
    CourseDataRef.onValue.listen((DatabaseEvent event) {
      CourseList.clear();
      CourseDuration.clear();
      CourseFee.clear();
      NextBatchOpening.clear();
      SyllabusImageUrl.clear();

      final CourseData = event.snapshot.value;

      setState(() {
        if (CourseData != null && CourseData is Map<Object?, Object?>) {
          CourseData.forEach((key, value) async {
            idlist.add(key);
            if (value != null && value is Map<Object?, Object?>) {
              if (uid == value['uid']) {
                var datav = value['CourseName'];
                CourseList.add(datav);
                var CourseDuration = value['CourseDuration'];
                var CourseFee = value['CourseFee'];
                var NextBatchOpening = value['NextBatchOpening'];

                try {
                  var Reference = FirebaseStorage.instance
                      .ref()
                      .child("Syllabus-pdf/${datav.toString()}");
                  var tempurl = await Reference.getDownloadURL();
                  setState(() {
                    this.CourseDuration[datav] = CourseDuration;
                    this.CourseFee[datav] = CourseFee;
                    this.NextBatchOpening[datav] = NextBatchOpening;
                    this.SyllabusImageUrl[datav] = tempurl;
                  });
                } catch (e) {
                  print(e);
                  print(e);
                }
              }

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
              "Courses",
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
              itemCount: CourseList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyCard(
                    title: CourseList[index].toString(),
                    duration:
                        CourseDuration[CourseList[index].toString()].toString(),
                    fee: CourseFee[CourseList[index].toString()].toString(),
                    nextopening: NextBatchOpening[CourseList[index].toString()]
                        .toString(),
                    photo: SyllabusImageUrl[CourseList[index].toString()]
                        .toString(),
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
  final String duration;
  final String fee;
  final String nextopening;
  final String id;
  final String photo;

  MyCard(
      {required this.title,
      required this.duration,
      required this.fee,
      required this.nextopening,
      required this.id,
      required this.photo});

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
                 Image.asset(
                        "lib/assets/pdfimg.png",
                        width: 100,
                        height: 100,
                      ),
                  SizedBox(height: 8.0),
                  Text(
                    "Course Name:" + " " + widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Course duration:" + " " + widget.duration.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Course Fee:" + " " + widget.fee,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Next Batch Opening:" + " " + widget.nextopening,
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
                              builder: (context) =>
                                  CourseUpdate(id: widget.id)));
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
                          FirebaseDatabase.instance.ref("Courses");
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
