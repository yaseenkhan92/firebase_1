import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("yaseen")),
<<<<<<< HEAD
      body: Container(child: Text("How")),
=======
      body: Container(),
>>>>>>> f5250b49975c84c02c0776788ddf3b3eb1d3515c
    );
  }
}
