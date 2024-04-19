import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyspot_discover/firebase_options.dart';
import 'package:studyspot_discover/pages/AuthProvider.dart';
import 'package:studyspot_discover/pages/adminhome.dart';
import 'package:studyspot_discover/pages/homepage.dart';
import 'package:studyspot_discover/pages/institutehome.dart';
import 'package:studyspot_discover/pages/instituteregwaitingpage.dart';
import 'package:studyspot_discover/pages/loginpage.dart';
import 'package:studyspot_discover/pages/userhome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => AuthProvide(), child: StudySpot_Discover()));
}

class StudySpot_Discover extends StatelessWidget {
  const StudySpot_Discover({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      debugShowCheckedModeBanner: false,
      home: AuthChecker(),
    );
  }
}

class AuthChecker extends StatefulWidget {
  const AuthChecker();

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  var institute = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  var institutee=false;

  @override
  void initState() {
    super.initState();

    DatabaseReference UserDataRef = FirebaseDatabase.instance.ref("users/");

    UserDataRef.onValue.listen((DatabaseEvent event) {
      final userData = event.snapshot.value;

      setState(() {
        if (userData != null && userData is Map<Object?, Object?>) {
          userData.forEach((key, value) {
            User? user = auth.currentUser;
            String uid = user!.uid;

            if (uid == key) {
              print(
                  "$key-----------------------------------------------$value");
              if (value != null && value is Map<Object?, Object?>) {
                value.forEach((key, value) {
                  if (value != null && value is Map<Object?, Object?>) {
                    //  User? user = auth.currentUser;
                    //   String uid = user!.uid;
                    // var datav = value['staftype'];
                    //  value.forEach((key,value){
                    //  if( value != null && value is Map<Object?,Object?>){
                    if (value['institute'] == "true" &&
                        value['status'] == "null") {
                      institute = true;
                    } else if (value['institute'] == "true" &&
                        value['status'] == "accept") {
                      institute = false;
                      institutee = true;
                    }

                    print(value['fname']);
                  }
                });
              }
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        User? user = snapshot.data;
        if (user == null) {
          return LoginPage();
        } else {
          if (user!.uid == "QxTSYRTP2idXSIaQ9Yse7bBu7MA3") {
            return AdminHome();
          } else if (institute == true) {
            return Institute_reg_waiting();
          } else if (institute == false && institutee == true) {
            return InstituteHome();
          } else {
            return UserHome();
          }
        }
      },
    );
  }
}
