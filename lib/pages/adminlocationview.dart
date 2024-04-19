import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/admincategory.dart';
import 'package:studyspot_discover/pages/adminhome.dart';
import 'package:studyspot_discover/pages/adminlocation.dart';
import 'package:studyspot_discover/pages/adminlocationupdate.dart';
import 'package:studyspot_discover/pages/loginpage.dart';

class ViewLocation extends StatefulWidget {
  const ViewLocation({super.key});

  @override
  State<ViewLocation> createState() => _ViewLocationState();
}

class _ViewLocationState extends State<ViewLocation> {
  List LocationList = [""];
  List idlist = [];

  @override
  void initState() {
    super.initState();
    DatabaseReference LocationDataRef =
        FirebaseDatabase.instance.ref("locations");
    LocationDataRef.onValue.listen((DatabaseEvent event) {
      LocationList.clear();

      final LocationData = event.snapshot.value;

      setState(() {
        if (LocationData != null && LocationData is Map<Object?, Object?>) {
          LocationData.forEach((key, value) async {
            idlist.add(key);
            print("==========================${idlist}");
            if (value != null && value is Map<Object?, Object?>) {
              var datav = value['LocationName'];
              LocationList.add(datav);
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
                //  Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AdminCategory()));
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
              "Locations",
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
              itemCount: LocationList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyCard1(
                    Location: LocationList[index].toString(),
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

class MyCard1 extends StatefulWidget {
  final String Location;
  final String id;

  MyCard1({required this.Location, required this.id});

  @override
  State<MyCard1> createState() => _MyCard1State();
}

class _MyCard1State extends State<MyCard1> {
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
                  Text(
                    widget.Location,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UpdateLocation(id: widget.id)));
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
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      print(
                          "0000000000000000000000000000000000000000000${widget.id}");
                      if (widget.id != null &&
                          widget.id.toString().isNotEmpty) {
                        DatabaseReference ref =
                            FirebaseDatabase.instance.ref("locations");
                        await ref.child(widget.id.toString()).remove();
                      } else {
                        print("Error: widget.id is null or empty");
                      }
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
