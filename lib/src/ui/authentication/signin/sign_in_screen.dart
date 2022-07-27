import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whisky_hunter/src/comp/dialog/tm_dialog.dart';
import 'package:whisky_hunter/src/constant/constant.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SignIn(),
          TextButton(
              onPressed: () {
                Get.offAllNamed(TMRoute.signup.name!);
              },
              child: const Text("Sign Up"))
        ],
      ),
    );
  }
}

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalManager globalManager = Get.find();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'LOGIN',
              style: TMThemeData.fromContext(context).textNameWhiskyBlack,
            ),
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
              height: 12,
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
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: signIn,
                  child: Container(
                    height: 56,
                    width: 220,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TMThemeData.fromContext(context).text_16_500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      firebase_auth.UserCredential userCredential =
          await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      globalManager.uId = userCredential.user!.uid;
      Get.offAndToNamed(TMRoute.main.name!);
    } catch (e) {
      String err = e.toString();
      TMDialog.show(context, title: err, okText: 'OK');
    }
  }
}
