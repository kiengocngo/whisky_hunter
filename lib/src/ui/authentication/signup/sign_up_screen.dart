import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whisky_hunter/src/comp/button.dart/tm_button.dart';
import 'package:whisky_hunter/src/comp/dialog/tm_dialog.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "SIGN UP",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                      hintText: 'UserName',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TMButton(
                  content: "Sign Up",
                  onTap: () async {
                    try {
                      firebase_auth.UserCredential userCredential =
                          await firebase_auth.FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userCredential.user!.uid)
                          .set({
                        'uid': userCredential.user!.uid,
                        'user_name': _userNameController.text,
                        'birth_day': '',
                        'address': '',
                        'img_profile': '',
                      });
                      Get.offAndToNamed(TMRoute.info.name!, arguments: [
                        userCredential.user!.uid,
                      ]);
                    } catch (e) {
                      String err = e.toString();
                      TMDialog.show(context, title: err, okText: 'Ok');
                    }
                  },
                ),
              ],
            ),
          ))),
    );
  }
}
