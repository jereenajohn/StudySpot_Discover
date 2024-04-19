import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/loginpage.dart';
import 'package:studyspot_discover/pages/userviewcourses.dart';
import 'package:studyspot_discover/pages/userviewplacement.dart';

class User_Big_View_Institute extends StatefulWidget {
  var id;
  var uid;
  User_Big_View_Institute({required this.id, var this.uid});

  @override
  State<User_Big_View_Institute> createState() =>
      _User_Big_View_InstituteState();
}

class _User_Big_View_InstituteState extends State<User_Big_View_Institute> {
  List AboutList = [""];
  var CompanyDescList = {};
  var categorylist = {};

  var PhoneNumberList = {};
  var EmailAddress = {};
  var Address = {};
  var Pincode = {};
  var idlist = [];
  var CompanyImageUrl = {};

  var datav;
  var des;
  var address;
  var category;
  var phno;
  var pincode;
  var email;
  var tempurl;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

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
            print(
                "bigid==============================00000000000000000${widget.id}");
            print(
                "biguuuuuuuuuuuid==============================00000000000000000${widget.uid}");

            if (value != null && value is Map<Object?, Object?>) {
              if (key == widget.id) {
                datav = value['CompanyName'];

                AboutList.add(datav);
                des = value['CompanyDesc'];
                category = value['Category'];

                phno = value['PhoneNumber'];
                email = value['EmailAddress'];
                address = value['Address'];
                pincode = value['Pincode'];

                try {
                  var Reference = FirebaseStorage.instance
                      .ref()
                      .child("Company-image/${datav.toString()}");
                  tempurl = await Reference.getDownloadURL();
                  setState(() {
                    CompanyImageUrl[datav] = tempurl;
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
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      tempurl.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        datav.toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.white,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        des.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        address.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        category.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        phno.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        email.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        pincode.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              padding: EdgeInsets.all(10.0),
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => User_View_courses(
                                id: widget.id, uid: widget.uid)));
                    print('Card tapped');
                  },
                  child: Card(
                    elevation: 5,
                    child: ClipRRect(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          "lib/assets/courses.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => User_view_Placement(
                                  id: widget.id, uid: widget.uid)));
                    },
                    child: ClipRRect(
                      child: SizedBox(
                        child: Image.asset(
                          "lib/assets/pl.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
