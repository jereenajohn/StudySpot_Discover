import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/loginpage.dart';
import 'package:studyspot_discover/pages/userpayment.dart';

class User_enroll_course extends StatefulWidget {
  var id;
  var instid;
  var fees;

  User_enroll_course({required this.id, required this.instid,required this.fees});

  @override
  State<User_enroll_course> createState() => _User_enroll_courseState();
}

class _User_enroll_courseState extends State<User_enroll_course> {
  TextEditingController Name = TextEditingController();
  TextEditingController CourseName = TextEditingController();

  TextEditingController Phno = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

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
          SizedBox(height: 10),
          Text(
            "Register Course",
            style: TextStyle(fontSize: 20, color: Colors.purple),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: Name,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  hintText: "Enter Your Name"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: CourseName,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  hintText: "Enter Course Name"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: Phno,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  hintText: "Enter phone number"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
         ElevatedButton(
  onPressed: () async {
    User? user = auth.currentUser;
    String uid = user!.uid;
    if (Name.text.isNotEmpty || CourseName.text.isNotEmpty || Phno.text.isNotEmpty) {
      DatabaseReference ref = FirebaseDatabase.instance.ref("UserRegisterCourse");
      DatabaseReference cat = ref.push();

      await cat.set({
        "Name": Name.text,
        "CourseName": CourseName.text,
        "phno": Phno.text,
        "uid": uid,
        "instid": widget.instid,
        // "status": "null"
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Registration Successful"),
            content: Text("You have successfully registered for the course."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserPayment(
                        id: widget.id,
                        instid: widget.instid,
                        coursefees: widget.fees,
                      ),
                    ),
                  );
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      print("Fill out the fields");
    }
  },
  child: Text("Register"),
)

        ],
      ),
    );
  }
}
