import 'package:firebase_1/ui/auth/loginsceen.dart';
import 'package:firebase_1/utils/utils.dart';
import 'package:firebase_1/widgets/round_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  final formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // will popscope are generally used for the back the app in a andioid simulator through the android buttons in the ottoms
      onWillPop: () async {
        SystemNavigator.pop();

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Sign up Screen"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                          hint: Text("Enter your email "),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'emial';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: passwordcontroller,
                        decoration: InputDecoration(
                          hint: Text("Enter your password "),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'password ';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                RoundedButton(
                  title: "sign up your account  ",
                  loading: loading,
                  ontap: () {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      _auth
                          .createUserWithEmailAndPassword(
                            email: emailcontroller.text.trim(),
                            password: passwordcontroller.text.trim(),
                          )
                          .then((value) {
                            setState(() {
                              loading = false;
                            });
                          })
                          .onError((error, stackTrace) {
                            setState(() {
                              loading = false;
                            });
                            Utils().toastmessage(error.toString());
                          });
                    }
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text("Already have an account"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text("login"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
