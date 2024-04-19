import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/instituteabout.dart';
import 'package:studyspot_discover/pages/instituteaddcourse.dart';
import 'package:studyspot_discover/pages/instituteaddplacement.dart';
import 'package:studyspot_discover/pages/instituteviewenquiry.dart';
import 'package:studyspot_discover/pages/instituteviewregusers.dart';
import 'package:studyspot_discover/pages/loginpage.dart';

class InstituteHome extends StatefulWidget {
  const InstituteHome({super.key});

  @override
  State<InstituteHome> createState() => _InstituteHomeState();
}

class _InstituteHomeState extends State<InstituteHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(

      // title: Text(
      //   "Institute Home",
      //   style: TextStyle(
      //       fontSize: 15,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.purple,
      //       letterSpacing: 1.5,
      //       shadows: [
      //         Shadow(
      //             blurRadius: 3.0,
      //             color: Colors.white,
      //             offset: Offset(2.0, 2.0))
      //       ]),
      // ),
      // ),
      // drawer: Drawer(
      //   child: ListView(
      //     children: <Widget>[
      //       DrawerHeader(
      //         decoration: BoxDecoration(color: Colors.purple),
      //         child: Text(
      //           "Dashboard",
      //           style: TextStyle(
      //               fontSize: 24, color: Color.fromARGB(255, 252, 252, 253)),
      //         ),
      //       ),
      //       ListTile(
      //         title: Text("Home"),
      //         leading: Icon(Icons.home),
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => InstituteHome()));
      //         },
      //       ),
      //       ListTile(
      //         title: Text("About"),
      //         leading: Icon(Icons.category),
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => InstituteAbout()));
      //         },
      //       ),
      //       ListTile(
      //         title: Text("Courses"),
      //         leading: Icon(Icons.location_city),
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => AddCourses()));
      //         },
      //       ),
      //       ListTile(
      //         title: Text('Enquires'),
      //         leading: Icon(Icons.people),
      //         onTap: () {
      //           // Navigator.push(context,
      //           //     MaterialPageRoute(builder: (context) => AdminViewInstitutes()));
      //         },
      //       ),
      //       ListTile(
      //         title: Text('Registered Users'),
      //         leading: Icon(Icons.people),
      //         onTap: () {
      //           // Navigator.push(context,
      //           //     MaterialPageRoute(builder: (context) => AdminViewInstitutes()));
      //         },
      //       ),
      //       ListTile(
      //         title: Text('Placements'),
      //         leading: Icon(Icons.people),
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => Placements_Add()));
      //         },
      //       ),
      //       ListTile(
      //         title: Text('Placement Videos'),
      //         leading: Icon(Icons.people),
      //         onTap: () {
      //           // Navigator.push(context,
      //           //     MaterialPageRoute(builder: (context) => AdminViewInstitutes()));
      //         },
      //       ),
      //       ListTile(
      //         title: Text('logout'),
      //         leading: Icon(Icons.logout),
      //         onTap: () async {
      //           FirebaseAuth.instance.signOut();
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (contex) => LoginPage()));
      //           print('Buttonpressed');
      //         },
      //       )
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
            width: 540,
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
                // Center(
                //   child: Text(
                //     "Institute Home",
                //     style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: Colors
                //           .white, // Change text color to white for better visibility
                //     ),
                //   ),
                // ),
                    Positioned(
                  left: 25, // Adjust the position of the image as needed
                  child: GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Image.asset(
                      'lib/assets/st.png',
                      width: 120,
                      height: 120,
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
            Row(
              children: [
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InstituteAbout()),
                        );
                      },
                      child: Container(
                        height: 200, // Adjust the height as needed
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'lib/assets/about1.png',
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "About",
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
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddCourses()),
                        );
                      },
                      child: Container(
                        height: 200, // Adjust the height as needed
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'lib/assets/courses1.png', // Replace 'lib/assets/courses_icon.png' with your image asset path
                                  width: 70, // Adjust width as needed
                                  height: 70, // Adjust height as needed
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Courses",
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
            Row(
              children: [
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => View_Enquiry()),
                        );
                      },
                      child: Container(
                        height: 200, // Adjust the height as needed
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'lib/assets/enq1.png', // Replace 'lib/assets/courses_icon.png' with your image asset path
                                  width: 70, // Adjust width as needed
                                  height: 70, // Adjust height as needed
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Enquires",
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
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => View_reg_users()),
                        );
                      },
                      child: Container(
                        height: 200, // Adjust the height as needed
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'lib/assets/reg1.png', // Replace 'lib/assets/courses_icon.png' with your image asset path
                                  width: 70, // Adjust width as needed
                                  height: 70, // Adjust height as needed
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Registred Users",
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
            Row(
              children: [
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InstituteAbout()),
                        );
                      },
                      child: Container(
                        height: 200, // Adjust the height as needed
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'lib/assets/vid1.png', // Replace 'lib/assets/courses_icon.png' with your image asset path
                                  width: 70, // Adjust width as needed
                                  height: 70, // Adjust height as needed
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Videos",
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
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Placements_Add()),
                        );
                      },
                      child: Container(
                        height: 200, // Adjust the height as needed
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'lib/assets/place1.png', // Replace 'lib/assets/courses_icon.png' with your image asset path
                                  width: 70, // Adjust width as needed
                                  height: 70, // Adjust height as needed
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Placement",
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
          ],
        ),
      ),
    );
  }
}
