import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:studyspot_discover/pages/loginpage.dart';

class UserPayment extends StatefulWidget {
  var id;
  var instid;
  var coursefees;

  UserPayment(
      {required this.id, required this.instid, required this.coursefees});

  @override
  State<UserPayment> createState() => _UserPaymentState();
}

class _UserPaymentState extends State<UserPayment> {
  TextEditingController cardHolder = TextEditingController();

  TextEditingController cardNumber = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController cvv = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  List regdetails = [];

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
          SizedBox(height: 10),
          Text(
            "Payment",
            style: TextStyle(fontSize: 20, color: Colors.purple),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: cardHolder,
              decoration: InputDecoration(
                labelText: "Card Holder Name",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: cardNumber,
              decoration: InputDecoration(
                labelText: "Card Number",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: expiryDate,
              decoration: InputDecoration(
                labelText: "Expiry Date",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: cvv,
              decoration: InputDecoration(
                labelText: "CVV",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              addpayment();
              statusupdate();
            },
            child: Text(widget.coursefees),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              textStyle: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  void addpayment() async {
    User? user = auth.currentUser;
    String uid = user!.uid;
    if (cardHolder.text.isNotEmpty ||
        cardNumber.text.isNotEmpty ||
        expiryDate.text.isNotEmpty ||
        cvv.text.isNotEmpty) {
      DatabaseReference ref = FirebaseDatabase.instance.ref("Payment");
      DatabaseReference cat = ref.push();

      await cat.set({
        "CardHolder": cardHolder.text,
        "CardNumber": cardNumber.text,
        "ExpiryDate": expiryDate.text,
        "cvv": cvv.text,
        "uid": uid,
        "instid": widget.instid,
        "id": widget.id,
      });

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => UserPayment()));
    } else {
      print("fill out the fields");
    }
  }

  void statusupdate() async {
    User? user = auth.currentUser;
    String uidd = user!.uid;
    DatabaseReference yeardataref =
        FirebaseDatabase.instance.ref("UserRegisterCourse");

    await yeardataref.onValue.listen((DatabaseEvent event) {
      var data = event.snapshot.value;
      setState(() {
        if (data != null && data is Map<Object?, Object?>) {
          data.forEach((key, value) async {
            if (value != null && value is Map<Object?, Object?>) {
              regdetails.add(value);
            }
          });
        }
      });
      for (int i = 0; i < regdetails.length; i++) {
        if (regdetails[i]['uid'] == uidd &&
            regdetails[i]['instid'] == widget.instid) {
              print("======================>>>>>>>>>>>>>>>>>>>${regdetails[i][Key]}");
              
          // yeardataref.update({
          //   "${regdetails[i][Key].toString()}/status": "paid",
          // });
        }
      }
    });
  }
}
