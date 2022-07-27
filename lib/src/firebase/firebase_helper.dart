import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:whisky_hunter/src/constant/constant.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';

class FirebaseHelper {
  static final FirebaseHelper firebaseHelper = FirebaseHelper._internal();
  FirebaseHelper._internal();
  late AuthCredential authCredential;
  final GlobalManager globalManager = Get.find();
  Future<User?> signInWithEmailAndPassword({
    String? email,
    String? password,
  }) async {
    User? user;

    try {
      UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email ?? "",
      password: password ?? "",
    );
    globalManager.uId = userCredential.user!.uid;
    user = userCredential.user;
    Get.toNamed(TMRoute.main.name!);
    return user;
    }on FirebaseAuthException catch (e) {
      log(e.toString());
      throw FirebaseAuthException(code:  e.code, message: e.message);
    }
  }

  Future<User?> creatUserWithEmailAndPassword({
    String? email,
    String? password,
  }) async {
    User? user;

    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email ?? "", password: password ?? "");
    user = userCredential.user;
    Get.toNamed(TMRoute.signin.name!);
    return user;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
