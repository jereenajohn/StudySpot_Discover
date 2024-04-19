import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/admincategory.dart';
import 'package:studyspot_discover/pages/adminlocation.dart';
import 'package:studyspot_discover/pages/adminviewinstitute.dart';
import 'package:studyspot_discover/pages/loginpage.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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
                      print(
                          "ereerrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr$e");
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
      body: Column(
        children: [
          Container(
            width: 360,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0), // Adjust the value as needed
                bottomRight:
                    Radius.circular(20.0), // Adjust the value as needed
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.2), // Adjust the shadow color and opacity
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2), // Offset of the shadow
                ),
              ],
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.black87],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    "Admin Home",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .white, // Change text color to white for better visibility
                    ),
                  ),
                ),
                Positioned(
                  right: 25, // Adjust the position of the image as needed
                  bottom: 25, // Adjust the position of the image as needed
                  child: GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Image.asset(
                      'lib/assets/exit.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    width: 200,
                    height: 150,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AdminCategory()), // Replace AdminCategoryPage() with the page you want to navigate to
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Image.asset(
                                'lib/assets/cat.png', // Replace with your image asset path
                                height: 60,
                                width: 60,
                              ),
                              SizedBox(height: 15),
                              Text(
                                "Categories",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                    letterSpacing: 1.5,
                                    shadows: [
                                      Shadow(
                                          blurRadius: 3.0,
                                          color: Colors.white,
                                          offset: Offset(2.0, 2.0))
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    width: 200,
                    height: 150,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddLocation()), // Replace AdminCategoryPage() with the page you want to navigate to
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Image.asset(
                                    'lib/assets/locationicons.png', // Replace with your image asset path
                                    height: 60,
                                    width: 60,
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    "Locations",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple,
                                        letterSpacing: 1.5,
                                        shadows: [
                                          Shadow(
                                              blurRadius: 3.0,
                                              color: Colors.white,
                                              offset: Offset(2.0, 2.0))
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    width: 200,
                    height: 150,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AdminViewInstitutes()), // Replace AdminCategoryPage() with the page you want to navigate to
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 22),
                                    child: Image.asset(
                                      'lib/assets/bank.png', // Replace with your image asset path
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    "Institutions",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple,
                                        letterSpacing: 1.5,
                                        shadows: [
                                          Shadow(
                                              blurRadius: 3.0,
                                              color: Colors.white,
                                              offset: Offset(2.0, 2.0))
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
