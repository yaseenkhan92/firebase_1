import 'package:firebase_1/ui/auth/verify_code.dart';
import 'package:firebase_1/utils/utils.dart';
import 'package:firebase_1/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginWithNbr extends StatefulWidget {
  const LoginWithNbr({super.key});

  @override
  State<LoginWithNbr> createState() => _LoginWithNbrState();
}

class _LoginWithNbrState extends State<LoginWithNbr> {
  String fullphonenumber = '';
  bool loading = false;
  final auth = FirebaseAuth.instance;

  final phonenumbercontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login with phone nbr "),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            IntlPhoneField(
              controller: phonenumbercontroller,
              decoration: InputDecoration(
                labelText: 'Enter your phone number',
                border: OutlineInputBorder(),
              ),
              initialCountryCode: 'PK', // Pakistan flag by default
              onChanged: (phone) {
                fullphonenumber = phone.completeNumber;
                // automatically gives +923001234567
              },
            ),

            SizedBox(height: 50),

            RoundedButton(
              title: "login",
              loading: loading,
              ontap: () {
                setState(() {
                  loading = true;
                });
                auth.verifyPhoneNumber(
                  phoneNumber: fullphonenumber,
                  verificationCompleted: (context) {
                    setState(() {
                      loading = false;
                    });
                  },
                  verificationFailed: (e) {
                    Utils().toastmessage(e.toString());
                    setState(() {
                      loading = false;
                    });
                  },
                  codeSent: (String verification, int? token) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Verifycodescreen(verficationID: verification);
                        },
                      ),
                    );
                    setState(() {
                      loading = false;
                    });
                  },
                  codeAutoRetrievalTimeout: (e) {
                    Utils().toastmessage(e.toString());
                    setState(() {
                      loading = false;
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
