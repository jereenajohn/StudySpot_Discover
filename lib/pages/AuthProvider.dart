import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AuthProvide extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;

  String? VerificationidImp;
  Future phonesignin(String Number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: Number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        VerificationidImp = verificationId;
        print("code sent successfully");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("Your code is timeout");
      },
    );
  }

  otpverify(otp, Fname, Lname, email, phno, Password) async {
    try {
      FirebaseDatabase database = FirebaseDatabase.instance;
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: VerificationidImp!,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
      User? user = auth.currentUser;
      String uid = user!.uid;
      DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
      DatabaseReference newuser = ref.push();

      await newuser.set({
        "fname": Fname,
        "lname": Lname,
        "email": email,
        "phno": phno,
        "Password": Password,
        "institute": "false"
      });
    } catch (e) {
      print("the message is $e");
    }
  }

  Future phonesignin_institution(String Number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: Number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        VerificationidImp = verificationId;
        print("code sent successfully");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("Your code is timeout");
      },
    );
  }

  otpverify_institution(otp, Fname, email, phno, location) async {
    try {
      FirebaseDatabase database = FirebaseDatabase.instance;
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: VerificationidImp!,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
      User? user = auth.currentUser;
      String uid = user!.uid;
      DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
      DatabaseReference newuser = ref.push();

      await newuser.set({
        "fname": Fname,
        "email": email,
        "phno": phno,
        "location": location,
        "institute": "true",
        "status" : "null"
      });
    } catch (e) {
      print("the message is $e");
    }
  }

  loginUser(otp, phno) async {
    try {
      FirebaseDatabase database = FirebaseDatabase.instance;
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: VerificationidImp!,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
      User? user = auth.currentUser;
      String uid = user!.uid;
      DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
    } catch (e) {
      print("the message is $e");
    }
  }
}
