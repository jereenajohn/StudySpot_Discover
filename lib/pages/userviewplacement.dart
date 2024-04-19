import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/loginpage.dart';

class User_view_Placement extends StatefulWidget {
  var id;
  var uid;
  User_view_Placement({required this.id, required this.uid});

  @override
  State<User_view_Placement> createState() => _User_view_PlacementState();
}

class _User_view_PlacementState extends State<User_view_Placement> {
  List CaptionList = [""];
  var PlacementImageUrl = {};
  List idlist = [];
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    User? user = auth.currentUser;
    String uid = user!.uid;
    DatabaseReference PlacementDataRef =
        FirebaseDatabase.instance.ref("placements");
    PlacementDataRef.onValue.listen((DatabaseEvent event) {
      CaptionList.clear();

      PlacementImageUrl.clear();
      final PlacementData = event.snapshot.value;

      setState(() {
        if (PlacementData != null && PlacementData is Map<Object?, Object?>) {
          PlacementData.forEach((key, value) async {
            idlist.add(key);
            if (value != null && value is Map<Object?, Object?>) {
              if (widget.uid == value['uid']) {
                var datav = value['Caption'];
                CaptionList.add(datav);

                try {
                  var Reference = FirebaseStorage.instance
                      .ref()
                      .child("placement-image/${datav.toString()}");
                  var tempurl = await Reference.getDownloadURL();
                  setState(() {
                    PlacementImageUrl[datav] = tempurl;
                  });
                } catch (e) {
                  print(
                      "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$e");
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
              "Placements",
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
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: CaptionList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyCard(
                    title: CaptionList[index].toString(),
                    photo: PlacementImageUrl[CaptionList[index].toString()]
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
  final String photo;
  final String id;

  MyCard({required this.title, required this.photo, required this.id});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  var CategoryImageUrl;

   void _showImagePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.network(
            widget.photo.toString(),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }

   @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              _showImagePopup(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.photo.toString(),
                      width: 130.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      widget.title,
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
      ),
    );
  }
}