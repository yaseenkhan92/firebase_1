import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_1/utils/utils.dart';
import 'package:firebase_1/widgets/round_button.dart';

import 'package:flutter/material.dart';

class Addfirestoredata extends StatefulWidget {
  const Addfirestoredata({super.key});

  @override
  State<Addfirestoredata> createState() => _AddfirestoredataState();
}

class _AddfirestoredataState extends State<Addfirestoredata> {
  final posteditingcontroller = TextEditingController();
  bool loading = false;
  final firestore = FirebaseFirestore.instance.collection("yaseen");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add firestore data"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            TextFormField(
              maxLines: 3,
              controller: posteditingcontroller,
              decoration: InputDecoration(
                hintText: 'whats in your mind ',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            RoundedButton(
              title: 'Add ',
              loading: loading,
              ontap: () {
                setState(() {
                  loading = true;
                });
                final id = DateTime.now().millisecondsSinceEpoch.toString();
                firestore
                    .doc(id)
                    .set({
                      "dee": posteditingcontroller.text.toString(),
                      "aa": id,
                    })
                    .then((value) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastmessage("Post is made");
                    })
                    .onError((error, stackTrace) {
                      setState(() {
                        loading = false;
                      });

                      Utils().toastmessage(error.toString());
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
