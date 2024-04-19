import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/loginpage.dart';
import 'package:studyspot_discover/pages/userenrollcourse.dart';

class User_View_courses extends StatefulWidget {
  var id;
  var uid;
  User_View_courses({required this.id, required this.uid});


  @override
  State<User_View_courses> createState() => _User_View_coursesState();
}

class _User_View_coursesState extends State<User_View_courses> {
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
              print(
                  "id==constroooooooooooooooooooooooooooooooooooooooooooo${widget.id}");
              print(
                  "id=========uiddddddddddddddddddddddddddddddddddddddddddd${value['uid']}");
              if (widget.uid == value['uid']) {
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
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.black87],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Image.asset(
                    "lib/assets/st.png",
                    height: 70,
                    width: 120,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ],
            ),
          ),
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
                    instid:widget.uid,

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
  final String instid;

  MyCard(
      {required this.title,
      required this.duration,
      required this.fee,
      required this.nextopening,
      required this.id,
      required this.photo
      ,required this.instid});
      
    

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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddressPopupForm(
                            onSubmit: (String name, String coursename,
                                String number) {
                              sendenquiry(name, coursename, number);
                            },
                          );
                        },
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 158, 27, 160),
                      ),
                    ),
                    child: Text(
                      "Enquiry",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>User_enroll_course(id:widget.id,instid:widget.instid,fees:widget.fee)));
                  }, child: Text("Enroll")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void sendenquiry(String name, String coursename, String number) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? user = auth.currentUser;
    String uid = user!.uid;

    DatabaseReference ref = FirebaseDatabase.instance.ref("enquiry");
    DatabaseReference newuser = ref.push();

    await newuser.set({
      "status": "enquired",
      "uid": uid,
      "instid":widget.instid,
      "name": name,
      "coursename": coursename,
      "phno": number
    });
  }
}

class AddressPopupForm extends StatefulWidget {
  final Function(String, String, String) onSubmit;

  const AddressPopupForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _AddressPopupFormState createState() => _AddressPopupFormState();
}

class _AddressPopupFormState extends State<AddressPopupForm> {
  final TextEditingController name = TextEditingController();
  final TextEditingController coursename = TextEditingController();
  final TextEditingController phno = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Your Address'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: coursename,
              decoration: InputDecoration(labelText: 'Course Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: phno,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 20),
Text(
  "Will Contact You Shortly!!!!!",
  style: TextStyle(
    color: Colors.grey, 
  ),
),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the popup
                  },
                  child: Text('Cancel'),
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () {
                    String name1 = name.text.trim();

                    String coursename1 = coursename.text.trim();
                    String number = phno.text.trim();

                    if (name1.isNotEmpty &&
                        coursename1.isNotEmpty &&
                        number.isNotEmpty) {
                      widget.onSubmit(name1, coursename1,
                          number); // Pass the data to the callback
                      Navigator.pop(context); // Close the popup
                    } else {
                      // Show an error or prompt the user to fill in all fields
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    name.dispose();

    coursename.dispose();
    phno.dispose();
    super.dispose();
  }
}
