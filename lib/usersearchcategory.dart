import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/loginpage.dart';
import 'package:studyspot_discover/pages/userbigviewinstitute.dart';

class User_Search_Category extends StatefulWidget {
  var cat;
   User_Search_Category({required this.cat});

  @override
  State<User_Search_Category> createState() => _User_Search_CategoryState();
}

class _User_Search_CategoryState extends State<User_Search_Category> {
  List AboutList = [""];
  var PhoneNumberList = {};
  var CompanyImageUrl = {};
  var idlist = [];
     var uid_d = {};

 
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    FetchAboutInstitute();
  }



  void FetchAboutInstitute() async {
    User? user = auth.currentUser;
    String uid = user!.uid;
    print("==========================hooooiiiiiiiiii${uid}");

    DatabaseReference AboutDataRef =
        FirebaseDatabase.instance.ref("AboutInstitute");
    await AboutDataRef.onValue.listen((DatabaseEvent event) {
      AboutList.clear();
      PhoneNumberList.clear();
      CompanyImageUrl.clear();

      final AboutData = event.snapshot.value;

      setState(() {
        if (AboutData != null && AboutData is Map<Object?, Object?>) {
          AboutData.forEach((key, value) async {
            idlist.add(key);
            print("---------=================${idlist}");
            if (value != null && value is Map<Object?, Object?>) {
              if(value['Category']==widget.cat)
              {
                    var datav = value['CompanyName'];
              AboutList.add(datav);
              var phno = value['PhoneNumber'];
                            var uid =value['uid'];


              try {
                var Reference = FirebaseStorage.instance
                    .ref()
                    .child("Company-image/${datav.toString()}");
                var tempurl = await Reference.getDownloadURL();
                setState(() {
                  // CategoryImageUrl.add(tempurl);
                  CompanyImageUrl[datav] = tempurl;

                  PhoneNumberList[datav] = phno;
                                    uid_d[datav]=uid;

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
         
         
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: 60,
                color: Color.fromARGB(255, 215, 201, 201),
              ),
              SizedBox(width: 4),
              Text(
                "Choose Your Institute",
                style: TextStyle(
                  color: Color.fromARGB(255, 215, 201, 201),
                ),
              ),
              SizedBox(width: 4),
              Container(
                height: 1,
                width: 60,
                color: Color.fromARGB(255, 215, 201, 201),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: AboutList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyCard(
                    title: AboutList[index].toString(),
                    phno:
                        PhoneNumberList[AboutList[index].toString()].toString(),
                    photo:
                        CompanyImageUrl[AboutList[index].toString()].toString(),
                    id: idlist[index],
                                        uid:uid_d[AboutList[index].toString()].toString(),

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
  final String phno;
  final String photo;
  final String id;
     final String uid;



  MyCard({
    required this.title,
    required this.phno,
    required this.photo,
    required this.id,
         required this.uid,

  });

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
           child: GestureDetector(
  onTap: () {
   Navigator.push(context, MaterialPageRoute(builder: (context)=>User_Big_View_Institute(id:widget.id,uid:widget.uid)));
    print('Card tapped!');
  },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                    widget.photo,
                    width: 120.0,
                    height: 150.0,
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
                      widget.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Phone Number: ${widget.phno}",
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
      ),)
    );
  }
}
