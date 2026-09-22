import 'package:firebase_1/utils/utils.dart';
import 'package:firebase_1/widgets/round_button.dart';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final posteditingcontroller = TextEditingController();
  bool loading = false;
  final database = FirebaseDatabase.instance.ref("Test");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add post"), backgroundColor: Colors.blue),
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
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                database.ref
                    .child(id)
                    .set({
                      'des': posteditingcontroller.text.toString(),
                      'aa': id,
                    })
                    .then((value) {
                      Utils().toastmessage("Post added");
                      setState(() {
                        loading = false;
                      });
                    })
                    .onError((error, stackTrace) {
                      Utils().toastmessage(error.toString());
                      setState(() {
                        loading = false;
                      });
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
