import 'package:firebase_1/post/post.dart';
import 'package:firebase_1/utils/utils.dart';
import 'package:firebase_1/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:intl_phone_field/intl_phone_field.dart';

class Verifycodescreen extends StatefulWidget {
  final verficationID;

  const Verifycodescreen({super.key, required this.verficationID});

  @override
  State<Verifycodescreen> createState() => _VerifycodescreenState();
}

class _VerifycodescreenState extends State<Verifycodescreen> {
  bool loading = false;
  final auth = FirebaseAuth.instance;

  final verfiycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify screen "),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            TextFormField(
              controller: verfiycontroller,
              decoration: InputDecoration(hintText: 'Enter your 6 digit code '),
            ),

            SizedBox(height: 50),

            RoundedButton(
              title: "Verify",
              loading: loading,
              ontap: () async {
                setState(() {
                  loading = true;
                });
                final crendential = PhoneAuthProvider.credential(
                  verificationId: widget.verficationID,
                  smsCode: verfiycontroller.text.toString(),
                );
                try {
                  await auth.signInWithCredential(crendential);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PostSceeen();
                      },
                    ),
                  );
                } catch (e) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastmessage(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
