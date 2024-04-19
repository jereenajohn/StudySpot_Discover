import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/admincategory.dart';
import 'package:studyspot_discover/pages/adminhome.dart';
import 'package:studyspot_discover/pages/adminlocation.dart';
import 'package:studyspot_discover/pages/adminviewinstitute.dart';
import 'package:studyspot_discover/pages/categoryupdate.dart';
import 'package:studyspot_discover/pages/loginpage.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List CategoryList = [""];
  // var CategoryDescription = {};
  // var CategoryImageUrl = {};
  List idlist = [];

  @override
  void initState() {
    super.initState();

    DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("Category");
    categoryDataRef.onValue.listen((DatabaseEvent event) {
      CategoryList.clear();
      // CategoryDescription.clear();
      // CategoryImageUrl.clear();

      final categoryData = event.snapshot.value;

      setState(() {
        if (categoryData != null && categoryData is Map<Object?, Object?>) {
          categoryData.forEach((key, value) async {
            idlist.add(key);
            if (value != null && value is Map<Object?, Object?>) {
              var datav = value['Categoryname'];
              CategoryList.add(datav);
              var des = value['Categorydes'];

              try {
                // var Reference = FirebaseStorage.instance.ref().child("category-image/${datav.toString()}");
                // var tempurl = await Reference.getDownloadURL();
                setState(() {
                  // CategoryImageUrl.add(tempurl);
                  // CategoryImageUrl[datav] = tempurl;
                  // CategoryDescription[datav] = des;

                  print(
                      "((((((((())))))))(((((((((((())))))))))))(((((((${des}");
                });
              } catch (e) {
                print(
                    "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$e");
                print(e);
                print(e);
              }

              print(
                  "-----------------------=====================--------------------------------key: $datav");
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
            ListTile(
              title: Text("Institutions"),
              leading: Icon(Icons.people),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminViewInstitutes()));
              },
            ),
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
              "Categories",
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
    itemCount: CategoryList.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: MyCard(
          title: CategoryList[index].toString(),
          // photo: CategoryImageUrl[CategoryList[index].toString()]
          //     .toString(),
          // des: CategoryDescription[CategoryList[index].toString()]
          //     .toString(),
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
  // final String photo;
  // final String des;
  final String id;

  MyCard({required this.title,  required this.id});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  var CategoryImageUrl;

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
                  // Image.network(
                  //   widget.photo.toString(),
                  //   width: 130.0,
                  //   height: 50.0,
                  //    fit: BoxFit.cover,
                  // ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  // Text(
                  //   widget.des.toString(),
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
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
                                  CategoryUpdate(id: widget.id)));
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
                          FirebaseDatabase.instance.ref("Category");
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
