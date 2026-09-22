import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_1/ui/firestore/add_firestore_data.dart';
import 'package:flutter/material.dart';

class FirestoreList extends StatefulWidget {
  const FirestoreList({super.key});

  @override
  State<FirestoreList> createState() => _FirestoreListState();
}

class _FirestoreListState extends State<FirestoreList> {
  final popediting = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection("yaseen").snapshots();
  final ref = FirebaseFirestore.instance.collection("yaseen");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore screen"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded( 
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder:
                  (BuildContext contex, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Some erorr ");
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              ref
                                  .doc(snapshot.data!.docs[index].id.toString())
                                  .update({
                                    'dee':
                                        " this text field is now updated on a direvt method ",
                                  });
                            },
                            title: Text(
                              snapshot.data!.docs[index]["dee"].toString(),
                            ),
                            subtitle: Text(
                              snapshot.data!.docs[index].id.toString(),
                            ),
                          );
                        },
                      );
                    }
                  },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Addfirestoredata();
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialogue(String title, String id) async {
    popediting.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update "),
          content: Container(
            child: TextField(
              controller: popediting,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
