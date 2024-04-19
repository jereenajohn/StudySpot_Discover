import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studyspot_discover/pages/institutionotp.dart';

class Institution_reg extends StatefulWidget {
  const Institution_reg({super.key});

  @override
  State<Institution_reg> createState() => _Institution_regState();
}

class _Institution_regState extends State<Institution_reg> {
  TextEditingController con13 = TextEditingController();
  TextEditingController con32 = TextEditingController();
  TextEditingController con42 = TextEditingController();
  String selectedValue = '';
  // String selectedValue1 = '';
  List<String> Locationlist = [];
  // List<String> Categorylist = [];

  var SelectedFile;

  @override
  void initState() {
    super.initState();

    fetchlocation();
    // fetchcategory();
  }

  void fetchlocation() async{
    print("haaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    DatabaseReference yeardataref = FirebaseDatabase.instance.ref("locations");

  await yeardataref.onValue.listen((DatabaseEvent event) {
      Locationlist.clear();
      var data = event.snapshot.value;
      setState(() {
        if (data != null && data is Map<Object?, Object?>) {
          data.forEach((key, value) async {
            if (value != null && value is Map<Object?, Object?>) {
              var location = value["LocationName"];
              Locationlist.add(location.toString());
              selectedValue = location.toString();
              print(Locationlist);
            }
          });
        }
      });
    });
  }

  // void fetchcategory() async {
  //   DatabaseReference yeardataref = FirebaseDatabase.instance.ref("Category");

  //  await yeardataref.onValue.listen((DatabaseEvent event) {
  //     Categorylist.clear();
  //     var data = event.snapshot.value;
  //     setState(() {
  //       if (data != null && data is Map<Object?, Object?>) {
  //         data.forEach((key, value) async {
  //           if (value != null && value is Map<Object?, Object?>) {
  //             var cat = value["Categoryname"];
  //             Categorylist.add(cat.toString());
  //             selectedValue1 = cat.toString();
  //             print(Categorylist);
  //           }
  //         });
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
              child: Column(
                children: [
                  Text(
                    "Create New Account",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    controller: con13,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      hintText: "Enter Institutions Name",
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                      controller: con32,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          hintText: "Enter Email ")),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: 340,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Select Location',
                        labelText: 'Location',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      child: DropdownButton<String>(
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                            print(selectedValue);
                          });
                        },
                        items: Locationlist.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // Container(
                  //   width: 340,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey),
                  //     borderRadius: BorderRadius.circular(18),
                  //   ),
                  //   child: InputDecorator(
                  //     decoration: InputDecoration(
                  //       border: InputBorder.none,
                  //       hintText: 'Select Category',
                  //       labelText: 'Category',
                  //       contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  //     ),
                  //     child: DropdownButton<String>(
                  //       value: selectedValue1,
                  //       onChanged: (String? newValue1) {
                  //         setState(() {
                  //           selectedValue1 = newValue1!;
                  //           print(selectedValue1);
                  //         });
                  //       },
                  //       items: Categorylist.map<DropdownMenuItem<String>>(
                  //           (String value1) {
                  //         return DropdownMenuItem<String>(
                  //           value: value1,
                  //           child: Text(value1),
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 25,
                  // ),
                  TextField(
                      controller: con42,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          hintText: "Enter Phone Number")),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        SelectLicense();
                      },
                      child: Text("Uploaad license")),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        UploadLicense();
                        var Phoneno = '+91${con42.text}';

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Institution_Otp(
                                      Fname: con13.text,
                                      email: con32.text,
                                      phno: Phoneno,
                                      location: selectedValue,
                                    )));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void SelectLicense() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          SelectedFile = File(result.files.single.path!);
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("File selecting Successfully"),
          backgroundColor: Color.fromARGB(255, 35, 143, 51),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("error selecting the file"),
        backgroundColor: Colors.red,
      ));
    }
  }

  void UploadLicense() async {
    try {
      var docpath = await getApplicationDocumentsDirectory();
      var path = "${docpath.absolute}.png";
      if (SelectedFile != null) {
        await FirebaseStorage.instance
            .ref()
            .child("license-image/${con13.text}")
            .putFile(SelectedFile);
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("File uploaded Successfully"),
        backgroundColor: Color.fromARGB(255, 35, 143, 51),
      ));
    } catch (e) {

      print("erorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr$e");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error in uploading  ${e}"),
        backgroundColor: Color.fromARGB(255, 146, 40, 40),
      ));
    }
  }
}
