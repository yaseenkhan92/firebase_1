import 'package:firebase_1/post/new_post.dart';
import 'package:firebase_1/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'package:flutter/material.dart';

class PostSceeen extends StatefulWidget {
  const PostSceeen({super.key});

  @override
  State<PostSceeen> createState() => _PostSceeenState();
}

class _PostSceeenState extends State<PostSceeen> {
  final auth = FirebaseDatabase.instance;
  final ref = FirebaseDatabase.instance.ref("Test");
  final searcheditingcontrollerr = TextEditingController();
  final popediting = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Postscreen"), backgroundColor: Colors.blue),
      body: Column(
        children: [
          TextFormField(
            controller: searcheditingcontrollerr,
            decoration: InputDecoration(
              hintText: "Search",
              border: OutlineInputBorder(),
            ),
            onChanged: (String value) {
              setState(() {});
            },
          ),

          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                final description = snapshot.child("des").value.toString();

                if (searcheditingcontrollerr.text.isEmpty) {
                  return ListTile(
                    title: Text(snapshot.child("des").value.toString()),
                    subtitle: Text(snapshot.child("aa").value.toString()),
                    trailing: PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          onTap: () {
                            showMyDialogue(
                              description,
                              snapshot.child("aa").value.toString(),
                            );
                          },
                          child: ListTile(
                            leading: Icon(Icons.edit),
                            title: Text("edit "),
                          ),
                        ),
                        PopupMenuItem(
                          value: 1,
                          onTap: () {
                            ref
                                .child(snapshot.child("aa").value.toString())
                                .remove();
                          },

                          child: ListTile(
                            leading: Icon(Icons.delete),
                            title: Text("Delete "),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (description.toLowerCase().contains(
                  searcheditingcontrollerr.text.toLowerCase().toString(),
                )) {
                  return ListTile(
                    title: Text(snapshot.child("des").value.toString()),
                    subtitle: Text(snapshot.child("aa").value.toString()),
                  );
                } else {
                  return Container();
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
                return NewPost();
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
                ref
                    .child(id)
                    .update({"des": popediting.text.toLowerCase()})
                    .then((value) {
                      setState(() {});
                      Utils().toastmessage("Post are updated ");
                    })
                    .onError((error, stackTrace) {
                      Utils().toastmessage(error.toString());
                    });
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
    //  Expanded(
    //         child: StreamBuilder(
    //           stream: ref.onValue,
    //           builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
    //             if (!snapshot.hasData) {
    //               return CircularProgressIndicator();
    //             } else {
    //               Map<dynamic, dynamic> map =
    //                   snapshot.data!.snapshot.value as dynamic;
    //               List<dynamic> list = [];
    //               list.clear();
    //               list = map.values.toList();

    //               return ListView.builder(
    //                 itemCount: snapshot.data!.snapshot.children.length,
    //                 itemBuilder: (context, Index) {
    //                   return ListTile(
    //                     title: Text(list[Index]['des']),
    //                     subtitle: Text(list[Index]['aa']),
    //                   );
    //                 },
    //               );
    //             }
    //           },
    //         ),
    //       ),
