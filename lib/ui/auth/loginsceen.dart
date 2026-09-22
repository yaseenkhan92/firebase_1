import 'package:firebase_1/post/post.dart';
import 'package:firebase_1/ui/auth/login_with_nbr.dart';
import 'package:firebase_1/ui/auth/signUPscreen.dart';
import 'package:firebase_1/utils/utils.dart';
import 'package:firebase_1/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim(),
        )
        .then((value) {
          Utils().toastmessage(value.user!.email.toString());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PostSceeen();
              },
            ),
          );
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Text("Login Screen"),
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
                title: "Please login ",
                loading: loading,
                ontap: () {
                  if (formkey.currentState!.validate()) {
                    login();
                  }
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text("Don't have an account"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    child: Text("Sign up"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginWithNbr();
                      },
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  // width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(child: Text("Sign in with phone nbr")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
